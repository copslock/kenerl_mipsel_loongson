Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IIaLM04143
	for linux-mips-outgoing; Tue, 18 Sep 2001 11:36:21 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IIaGe04140
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 11:36:16 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 18 Sep 2001 18:37:23 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id LAA05576;
	Tue, 18 Sep 2001 11:34:56 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id NAA04585; Tue, 18 Sep 2001 13:35:22 -0500
Message-ID: <3BA7946B.4070806@esstech.com>
Date: Tue, 18 Sep 2001 13:37:31 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Freeing global memory used only by __init functions
References: <200109181808.LAA05245@mail.esstech.com>
Content-Type: text/plain; charset=GB2312
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.esstech.com id LAA05576
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8IIaGe04141
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for the reply.  Sorry I didn't find the __initdata
attribute.  Is this stuff worth patching?

I'd make the following changes as a start:

in arch/mips/mips-boards/generic/printf.c:
Add __init to putPromChar
Add __init to getPromChar
Add __initdata to buf  (1k buffer)

in arch/mips/mips-boards/generic/cmdline.c:
Add __initdata to arcs_cmdline

Can someone point to a set of rules for submitting patches
for linux-mips?  I'm familiar with the methods used for the
kernel.  Is this the same?  I'm using 2.4.3 from the mips site.
Can I patch against that, or do I have to start from a
certain cvs version?

Thanks!

Gerald


Zhang Fuxin wrote:
> hi,Gerald Champagne£¬
>       I think __initdata attribute is the answer.You just need to 
> put init data in init data section(via __initdata),there are many examples
> in kernel.
> 
> 
> ÔÚ 2001-09-18 12:58:00 you wrote£º
> 
>>I noticed that several global buffers are used by a few functions marked
>>as __init functions.  I assume that the code space used by these functions
>>will be freed up when kernel initialization is completed, but can the
>>associated global memory be freed up as well?
>>
>>An example can be found in arch/mips/mips-boards/generic/cmdline.c:
>>
>>char arcs_cmdline[COMMAND_LINE_SIZE];
>>char * __init prom_getcmdline(void);
>>void  __init prom_init_cmdline(void);
>>
>>arcs_cmdline is only used by these two functions and one other function
>>marked as __init.
>>
>>This buffer is small, but it can apply to larger buffers as well.  For
>>example, in arch/mips/mips-boards/generic/printf.c, I think the functions
>>putPromChar and getPromChar should be marked as __init functions, and the
>>1k buffer "buf" is never used after initialization.  Can this 1k be recovered?
>>
>>I know kmalloc could normally be used in kernel code, but that won't work on
>>initialization code used before kmalloc is initialized.
>>
>>Thanks.
>>
>>Gerald
>>
> 
> Regards
>             Zhang Fuxin
>             fxzhang@ict.ac.cn
> 
> 
> 
> 
