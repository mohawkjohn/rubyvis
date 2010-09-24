module Protoruby
  class Scale
    class Ordinal 
      def pv
        Protoruby
      end
      def initialize(*args)
        @d=[] # domain
        @i={}
        @r=[]
        @band=0
        domain(*args)
      end
      def scale(x)
        if @i[x].nil?
          @d.push(x)
          @i[x]=@d.size-1
        end
        @r[@i[x] % @r.size]
      end
      def domain(*arguments)
        array,f=arguments[0],arguments[1]
        if(arguments.size>0)
          array= (array.is_a? Array) ? ((arguments.size>1) ? array.map(&f) : array) : arguments.dup
          @d=array.uniq
          i=pv.numerate(d)
          return self
        end
        @d
      end
      def range(*arguments)
        array,f = arguments[0],arguments[1]
        if(arguments.size>0)
        @r=(array.is_a? Array) ? ((arguments.size>1) ? array.map(&f) : array) : arguments.dup
          if @r[0].is_a? String
            @r=@r.map {|i| pv.color(i)}
          end
          self
        end
        @r
      end
      def split(min,max)
        step=(max-min).quo(domain().size)
        @r=pv.range(min+step.quo(2),max,step)
        self
      end
    end
  end
end