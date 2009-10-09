Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 04:08:59 +0200 (CEST)
Received: from qw-out-1920.google.com ([74.125.92.149]:45105 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491782AbZJICIw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 04:08:52 +0200
Received: by qw-out-1920.google.com with SMTP id 5so1549821qwc.54
        for <multiple recipients>; Thu, 08 Oct 2009 19:08:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=DR2OSbiDjZYyTt2HDenHGSKDzckM1JjOqhtF1+XxhxA=;
        b=heHzCY/4DIL/8a2T7cQ44Icj+z4pdkD8HI1SmBRff4jx0hdESjcYsjmVw8ERhS1hzu
         BMOPZKeNVvkJxkkZUv2f1tbdNgeGr1jVBm/DDenwcG16kLJ7tPLPSZCfnew6MfFdx0yv
         qk6zmhjwsUbH+cKZ28lAyQvD7tvXLrE54wZhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=bZwkejdJS9LEe2mQet3/zMDH2RuUSr0xPSlnX1n8SHyVmIjtY2P0DbzINIAUkcr0ic
         Hq9aATgG815rn/VueHIV9OureD+SGCKaN73+OeLjWvrOFVoUR17ZJqd8RbmU0+6cZuoT
         IBN1tlrd8TRNDNjWByuV0kT/1XNbmjwQ3oWSw=
Received: by 10.224.52.94 with SMTP id h30mr1940961qag.348.1255054129585;
        Thu, 08 Oct 2009 19:08:49 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 6sm1138738qwk.36.2009.10.08.19.08.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 19:08:42 -0700 (PDT)
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-mips@linux-mips.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20091008204447.GA14560@linux-mips.org>
References: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com>
	 <200910082221.12649.rjw@sisk.pl>  <20091008204447.GA14560@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 09 Oct 2009 10:08:28 +0800
Message-Id: <1255054108.5810.74.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-10-08 at 22:44 +0200, Ralf Baechle wrote:
> On Thu, Oct 08, 2009 at 10:21:12PM +0200, Rafael J. Wysocki wrote:
> 
> > > Here, we fix it via checking pfn is in the "System RAM" or not. and
> > > Seems pfn_valid() is not called in assembly code, we move it to
> > > "!__ASSEMBLY__" to ensure we can simply declare it via "extern int
> > > pfn_valid(unsigned long)" without Compiling Error.
> > > 
> > > (This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
> > >  and Sergei Shtylyov <sshtylyov@ru.mvista.com>)
> > 
> > Hmm.  What exactly would be wrong with using register_nosave_region() or
> > register_nosave_region_late() like x86 does?

Have tried to use register_nosave_region(), it works, but seems there is
something else wrong there.

> 
> That seems to be more the fix than pfn_valid / PageReserved fiddlery we were
> discussing in the other thread.  Thanks!

Just checked the arch/mips/loongson/common/mem.c, Seems it did not
register any reserved pages, in reality, two sections of memory are
reserved.

here should be the patch, tested it, works.

diff --git a/arch/mips/loongson/common/mem.c
b/arch/mips/loongson/common/mem.c
index 7c92f79..069d20b 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -15,11 +15,17 @@
 
 void __init prom_init_memory(void)
 {
-    add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+    add_memory_region(0x0, memsize << 20, BOOT_MEM_RAM);
+
+    add_memory_region(memsize << 20, LOONGSON_PCI_MEM_START - (memsize
<<
+                           20), BOOT_MEM_RESERVED);
 #ifdef CONFIG_64BIT
     if (highmemsize > 0)
        add_memory_region(LOONGSON_HIGHMEM_START,
                highmemsize << 20, BOOT_MEM_RAM);
+
+    add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START
-
+                   LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
 #endif /* CONFIG_64BIT */
 }

here is latest result:

$ cat /proc/iomem
00000000-0fffffff : System RAM
  00200000-0049ba17 : Kernel code
  0049ba18-005415ff : Kernel data
10000000-3fffffff : reserved ---> reserved page
40000000-7fffffff : pci memory space
  40000000-40ffffff : 0000:00:08.0
  41000000-4101ffff : 0000:00:07.0
  41020000-41020fff : 0000:00:09.0
    41020000-41020fff : ohci_hcd
  41021000-41021fff : 0000:00:0e.4
    41021000-41021fff : ohci_hcd
  41022000-41022fff : 0000:00:0e.5
    41022000-41022fff : ehci_hcd
  41023000-410230ff : 0000:00:07.0
    41023000-410230ff : 8139too
  41023100-410231ff : 0000:00:09.1
    41023100-410231ff : ehci_hcd
80000000-8fffffff : reserved  --> reserved page
90000000-bfffffff : System RAM

and what about pfn_valid(), is there a need to make it "robust"? or the
above patch is enough?

if the above patch is okay, I will send it to you later.

Regards,
	Wu Zhangjin
