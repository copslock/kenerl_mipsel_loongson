Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DFEA910594
	for linux-mips-outgoing; Mon, 13 Aug 2001 08:14:10 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DFE6j10590
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 08:14:06 -0700
Received: (qmail 23825 invoked from network); 13 Aug 2001 15:14:03 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 13 Aug 2001 15:14:03 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] modutils 2.4.6: Make __dbe_table available to modules 
In-reply-to: Your message of "Mon, 13 Aug 2001 16:49:22 +0200."
             <Pine.GSO.3.96.1010813164151.18279K-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Aug 2001 01:14:02 +1000
Message-ID: <16145.997715642@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 Aug 2001 16:49:22 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
>On Tue, 14 Aug 2001, Keith Owens wrote:
>> The only other change you have to make is to init_modules().  For mips
>> you create pointers to the kernel dbe tables and fill in archdata start
>> and end in kernel_module.  Since init_module is called before kmalloc
>> is ready, make the kernel dbe table a static variable.
>
> __dbe_table is initialized exactly like __ex_table, i.e. it's a separate
>ELF section with pointers to the start and the end computed in a linker
>script.  Thus it is fine.  The table has actually been present in the
>kernel for quite some time already. 

You still need this:

struct archdata {
  const struct exception_table_entry *dbe_table_start;
  const struct exception_table_entry *dbe_table_end;
};

In init_module:

#ifdef __mips__
  {
    extern const struct exception_table_entry __start___dbe_table[];
    extern const struct exception_table_entry __stop___dbe_table[];
    static struct archdata archdata_mips =
      { __start___dbe_table, __end___dbe_table };
    kernel_module.archdata_start = (char *)&archdata_mips;
    kernel_module.archdata_end = kernel_module.archdata_start +
	sizeof(archdata_mips);
  }
#endif

I really need to add an arch specific init_module routine as well,
instead of conditional code in init_module, but that means changing all
architectures.  Not today.
