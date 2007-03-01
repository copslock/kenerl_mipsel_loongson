Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2007 04:34:53 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.187]:49797 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038845AbXCAEea (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Mar 2007 04:34:30 +0000
Received: by nf-out-0910.google.com with SMTP id l24so759371nfc
        for <linux-mips@linux-mips.org>; Wed, 28 Feb 2007 20:33:29 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=hlns2RpgDa6MTh5+CfG44TH4djbtFn8B0ECJEal2xlb1+KeMtxTcOFaQEssIkBEulQc5hV8lz7ZB0rexBAgke0BkXC9NwxZMbbFjx1xhBDrygJDkL7bwUrruMjZizh91Bkdy/9TXYOMqqcFHvMxw3VA8GGwSyXKVw89BKfEUGIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=hJIjKRI5hafqVUSt+648nFqeNBh8LJS8yTdzZnRjPI9pgQ9wvkRlubQ5K8MAGJk6wCfcPWgztczx9i+YQblpuQVMFwZ0SVZr1obIxoOvC0RMWcNF5uI66P0F+3iS8k/sZpBvWZx6zPPcHFnTO8l1loYY0pcRyieTIUkyE/Ywmwc=
Received: by 10.82.187.16 with SMTP id k16mr478891buf.1172723609104;
        Wed, 28 Feb 2007 20:33:29 -0800 (PST)
Received: by 10.82.152.14 with HTTP; Wed, 28 Feb 2007 20:33:29 -0800 (PST)
Message-ID: <d28769380702282033t13a918cdkd8baf084a2ea79a8@mail.gmail.com>
Date:	Thu, 1 Mar 2007 12:33:29 +0800
From:	dejo <riamae@gmail.com>
Reply-To: riamae@gmail.com
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: early_initcall replacement
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070228024756.GA23519@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_33195_47410.1172723609039"
References: <d28769380702271755u675241b3vb8b265120a2c70ca@mail.gmail.com>
	 <20070228024756.GA23519@linux-mips.org>
Return-Path: <riamae@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riamae@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_33195_47410.1172723609039
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for your reply, sir. I found out that there's already a
plat_mem_setup defined in vr41xx/common/init.c that's why I cannot rename
the function invoked by early_initcall to plat_mem_setup.

Actually, when I examined it further, I found out that using arch_initcall
works just fine except that the add_memory_region is not called before
everything else. It causes error because there's no memory region allotted.

I did this:
/*arch/mips/vr41xx/common/init.c */
void __init plat_mem_setup(void)
{
    vr41xx_calculate_clock_frequency();

    timer_init();
    iomem_resource_init();
            add_memory_region(0, 0x04000000, BOOT_MEM_RAM);
}

and it worked! But it's not good practice isn't it? I might ruin the other
vr41xx boards. Do you have any suggestions? Thank you.

ria mae


On 2/28/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Wed, Feb 28, 2007 at 09:55:28AM +0800, dejo wrote:
>
> > Hello! I would like to ask what replaced early_initcall in the
> > 2.6.18.4kernel.
>
> What you need to change is
>
> o remove the early_initcall() line.
> o rename the function invoked by early_initcall to plat_mem_setup and
>    change its prototype to: "void __init plat_mem_setup(void)".
>
>   Ralf
>

------=_Part_33195_47410.1172723609039
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for your reply, sir. I found out that there&#39;s already a
plat_mem_setup defined in vr41xx/common/init.c that&#39;s why I cannot
rename the function invoked by early_initcall to plat_mem_setup.<br><br>Actually,
when I examined it further, I found out that using arch_initcall works
just fine except that the add_memory_region is not called before
everything else. It causes error because there&#39;s no memory region
allotted. <br><br>I did this:<br>/*arch/mips/vr41xx/common/init<div id="mb_2">.c */<span class="q"><br>void __init plat_mem_setup(void)<br></span>{<br>&nbsp;&nbsp;&nbsp; vr41xx_calculate_clock_frequency();<br><br>&nbsp;&nbsp;&nbsp; timer_init();<br>&nbsp;&nbsp;&nbsp; iomem_resource_init();
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_memory_region(0, 0x04000000, BOOT_MEM_RAM);
<br>}<br><br>and it worked! But it&#39;s not good practice isn&#39;t it? I
might ruin the other vr41xx boards. Do you have any suggestions? Thank
you. <br><br>ria mae</div><br><br><div><span class="gmail_quote">On 2/28/07, <b class="gmail_sendername">Ralf Baechle</b> &lt;<a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, Feb 28, 2007 at 09:55:28AM +0800, dejo wrote:<br><br>&gt; Hello! I would like to ask what replaced early_initcall in the<br>&gt; 2.6.18.4kernel.<br><br>What you need to change is<br><br> o remove the early_initcall() line.
<br> o rename the function invoked by early_initcall to plat_mem_setup and<br>&nbsp;&nbsp; change its prototype to: &quot;void __init plat_mem_setup(void)&quot;.<br><br>&nbsp;&nbsp;Ralf<br></blockquote></div><br>

------=_Part_33195_47410.1172723609039--
