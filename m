Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f99KLAm22997
	for linux-mips-outgoing; Tue, 9 Oct 2001 13:21:10 -0700
Received: from newsmtp2.atmel.com (newsmtp2.atmel.org [12.146.133.142])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f99KL5D22994
	for <linux-mips@oss.sgi.com>; Tue, 9 Oct 2001 13:21:05 -0700
Received: from hermes.sjo.atmel.com (newhermes [10.64.0.105])
	by newsmtp2.atmel.com (8.9.3+Sun/8.9.1) with ESMTP id NAA27884
	for <linux-mips@oss.sgi.com>; Tue, 9 Oct 2001 13:12:20 -0700 (PDT)
Received: from mmc.atmel.com (mail [10.127.240.34])
	by hermes.sjo.atmel.com (8.9.1b+Sun/8.9.1) with ESMTP id NAA14640
	for <linux-mips@oss.sgi.com>; Tue, 9 Oct 2001 13:12:42 -0700 (PDT)
Received: from mmc.atmel.com (IDENT:swang@pc-33.mmc.atmel.com [10.127.240.163])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id QAA23468
	for <linux-mips@oss.sgi.com>; Tue, 9 Oct 2001 16:20:50 -0400 (EDT)
Message-ID: <3BC36AE4.4D1EE63E@mmc.atmel.com>
Date: Tue, 09 Oct 2001 16:23:49 -0500
From: Shuanglin Wang <swang@mmc.atmel.com>
Reply-To: swang@mmc.atmel.com
Organization: ATMEL MMC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-8smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: MIPS and pci_alloc_consistent()?
Content-Type: multipart/alternative;
 boundary="------------6F0868FCCD2EF1871F9797F2"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--------------6F0868FCCD2EF1871F9797F2
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit

I tried to use the pci_alloc_consistent() to allocate one-page  DMA'able
memory for my device driver.  But, when booting up the system, it was
always  failed to execute the pci_alloc_consistent() by showing some
memory errors.

I traced the code to the function __alloc_page() in the file
mm/page_alloc.c, and found the system called  "wakeup_kswapd()".  But at
that time,  the kswapd process pointer is a NULL pointer and the
wakeup-related codes don't check the pointer is NULL or not,  so the
system was stopped because of dereferencing the null pointer.

I'm working on a MIPS SEAD-2 board using Linux kernel 2.4.3 MIPS
distrinution.
Anybody has some ideas about the problem?  Or are there other convenient
methods to allocate DMA'able memory?

Thanks,

--
Shuanglin Wang
Atmel Multimedia & Communications
3800 Gateway Centre, Suite 311
Morrisville, NC 27560



--------------6F0868FCCD2EF1871F9797F2
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
I tried to use the pci_alloc_consistent() to allocate one-page&nbsp; DMA'able
memory for my device driver.&nbsp; But, when booting up the system, it
was always&nbsp; failed to execute the pci_alloc_consistent() by showing
some memory errors.
<p>I traced the code to the function __alloc_page() in the file mm/page_alloc.c,
and found the system called&nbsp; "wakeup_kswapd()".&nbsp; But at that
time,&nbsp; the kswapd process pointer is a NULL pointer and the wakeup-related
codes don't check the pointer is NULL or not,&nbsp; so the system was stopped
because of dereferencing the null pointer.
<p>I'm working on a MIPS&nbsp;SEAD-2 board using Linux kernel 2.4.3 MIPS
distrinution.
<br>Anybody has some ideas about the problem?&nbsp; Or are there other
convenient methods to allocate DMA'able memory?
<p>Thanks,
<pre>--&nbsp;
Shuanglin Wang
Atmel Multimedia &amp; Communications
3800 Gateway Centre, Suite 311
Morrisville, NC 27560</pre>
&nbsp;</html>

--------------6F0868FCCD2EF1871F9797F2--
