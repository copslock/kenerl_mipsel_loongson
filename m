Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7VCgEo18080
	for linux-mips-outgoing; Fri, 31 Aug 2001 05:42:14 -0700
Received: from caroubier.wanadoo.fr (smtp-rt-6.wanadoo.fr [193.252.19.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7VCgBd18077
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 05:42:12 -0700
Received: from amyris.wanadoo.fr (193.252.19.150) by caroubier.wanadoo.fr; 31 Aug 2001 14:42:04 +0200
Received: from ez (193.253.196.250) by amyris.wanadoo.fr; 31 Aug 2001 14:41:28 +0200
Subject: Re: compile C++ code
From: Jean-Christophe ARNU <jc.arnu@wanadoo.fr>
To: kjlin <kj.lin@viditec-netmedia.com.tw>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <02b801c13203$f52ad440$056aaac0@kjlin>
References: <02b801c13203$f52ad440$056aaac0@kjlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 31 Aug 2001 14:38:38 -0400
Message-Id: <999283122.29395.45.camel@ez>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 31 Aug 2001 18:01:51 +0800, kjlin wrote:

> #mips-linux-gcc test.C
> /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/libgcc.a(frame.o): In function `decode_uleb128':
> /usr/src/redhat/BUILD/egcs-1.1.2/target-mips-linux/gcc/../../gcc/frame.c(.data+0x0): undefined reference to `pthread_create'
> /usr/mips-linux/bin/ld: bfd assertion fail ../../bfd/elf32-mips.c:5123
> mips-linux-gcc: Internal compiler error: program ld got fatal signal 11
> #mips-linux-g++ test.C
> /usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_create'
> /usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_getspecific'
> /usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_once'
> /usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_key_create'
> /usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_setspecific'
> 
	It seems you should link with pthread lib : 
	#mips-linux-g++ test.C -lpthread

	I think the libgcc.a should be linked with it ... Can anyone tell us
further on that subject?
-- 
Jean-Christophe ARNU
s/w developer 
Paratronic France
