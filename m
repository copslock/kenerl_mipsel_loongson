Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 22:47:20 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:13787 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027288AbXJYVqu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 22:46:50 +0100
Received: by nf-out-0910.google.com with SMTP id c10so587887nfd
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 14:46:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2cjMj2VsWWzLqtCgT9jxqZH0jN+0vPN9Xlh5RqJ8iUY=;
        b=Kbob0ODjaByFi3Nl2C5VgCyI8T7WQBBaheIB7fq/xrSKy3tyciwN9vkNMq80RxPGuNa9wtcs/MPq5JLUPj2QLWIXZjcJgwXAAz4wWzDvZILM9D6w6LSUF+1qaUIhzCe6FOJzBkjDNhi1xw895FqLuuCXxKEQqE3LsQ1re78p8aU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BAWX9FXrl84JfN44g8yscyzn7scJhsoIzBZ2ovbPO2c/53mEyX+TNDJ7IDbjO2JXz+UdbX6kwg3KrcVjvEHn88VHlQMuyqtvL7eb6QMfp/Sen2p4Z0mYgaAS+isNlO7aWylKXj7msRFbxEC5L3+2KJ/qSlXgZ2l0kgP4GlFdqyY=
Received: by 10.86.89.4 with SMTP id m4mr1666608fgb.1193348799329;
        Thu, 25 Oct 2007 14:46:39 -0700 (PDT)
Received: from ?192.168.123.7? ( [89.78.229.67])
        by mx.google.com with ESMTPS id e9sm5432117muf.2007.10.25.14.46.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2007 14:46:38 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [IDE] Fix build bug
Date:	Thu, 25 Oct 2007 23:41:38 +0200
User-Agent: KMail/1.9.7
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org,
	Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
References: <20071025135334.GA23272@linux-mips.org>
In-Reply-To: <20071025135334.GA23272@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710252341.38902.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips


Hi,

On Thursday 25 October 2007, Ralf Baechle wrote:
>   CC      drivers/ide/pci/generic.o
> drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> +section type conflict
> 
> This sort of build error is becoming a regular issue.  Either all or non
> of the elements that go into a particular section of a compilation unit
> need to be const.  Or an error may result such as in this case if
> CONFIG_HOTPLUG is unset.
> 
> Maybe worth a check in checkpatch.pl - but certainly gcc's interolerance
> is also being less than helpful here.
> 
> ---
>  drivers/ide/pci/generic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
> index f44d708..0047684 100644
> --- a/drivers/ide/pci/generic.c
> +++ b/drivers/ide/pci/generic.c
> @@ -67,7 +67,7 @@ MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE st
>  		.udma_mask	= ATA_UDMA6, \
>  	}
>  
> -static const struct ide_port_info generic_chipsets[] __devinitdata = {
> +static struct ide_port_info generic_chipsets[] __devinitdata = {
>  	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
>  
>  	{	/* 1 */

I would prefer to not remove const from generic_chipsets[] so:

[PATCH] drivers/ide/pci/generic: fix build for CONFIG_HOTPLUG=n

It turns out that const and __{dev}initdata cannot be mixed currently
and that generic IDE PCI host driver is also affected by the same issue:

On Thursday 25 October 2007, Ralf Baechle wrote:
>   CC      drivers/ide/pci/generic.o
> drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> +section type conflict

[ Also reported by Martijn Uffing <mp3project@sarijopen.student.utwente.nl>. ]

This patch workarounds the problem in a bit hackish way but without
removing const from generic_chipsets[] (it adds const to __setup() so
__setup_str_ide_generic_all becomes const).

Now all __{dev}initdata data in generic IDE PCI host driver are read-only
so it builds again (driver's .init.data section gets marked as READONLY).

Cc: Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -49,7 +49,7 @@ static int __init ide_generic_all_on(cha
 	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
 	return 1;
 }
-__setup("all-generic-ide", ide_generic_all_on);
+const __setup("all-generic-ide", ide_generic_all_on);
 #endif
 module_param_named(all_generic_ide, ide_generic_all, bool, 0444);
 MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE storage controllers.");
