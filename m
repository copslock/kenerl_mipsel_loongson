Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 16:55:26 +0100 (CET)
Received: (root@lappi.linux-mips.net) by lappi.linux-mips.net
	id S1101541AbYCZMju (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Mar 2008 13:39:50 +0100
Resent-From: root@lappi.linux-mips.net
Resent-Date: Wed, 26 Mar 2008 13:39:49 +0100
Resent-Message-ID: <20080326123949.GB2581@lappi.linux-mips.net>
Resent-To: linux-mips@linux-mips.org
Received: from oss.sgi.com ([192.48.170.157]:2776 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1101183AbYCZMOO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 13:14:14 +0100
Received: from p549F5321.dip.t-dialin.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2QBVUpk016060
	for <linux-mips@linux-mips.org>; Wed, 26 Mar 2008 05:13:33 -0700
Received: from relay01.mx.bawue.net ([193.7.176.67]:6878 "EHLO
	relay01.mx.bawue.net") by lappi.linux-mips.net with ESMTP
	id S1101594AbYCYRNC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Mar 2008 18:13:02 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id A926448917;
	Tue, 25 Mar 2008 18:12:30 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JeChJ-0005yJ-1f; Tue, 25 Mar 2008 17:12:29 +0000
Date:	Tue, 25 Mar 2008 17:12:29 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Larry Stefani <lstefani@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
Message-ID: <20080325171228.GD15685@networkno.de>
References: <15031.81072.qm@web38802.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15031.81072.qm@web38802.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <root@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: root@lappi.linux-mips.net
Precedence: bulk
X-list: linux-mips

Larry Stefani wrote:
> Hi,
> 
> I've been trying to upgrade from 2.6.16.18 to
> 2.6.16.60, but am seeing a hard lockup right before
> "INIT: version 2.78 booting" on my SB1250-based board.
> 
> I found a related discussion on the Debian mailing
> list:
> 
> http://groups.google.com/group/linux.debian.bugs.dist/browse_thread/thread/b7159ee25106c7f9
> 
> However, after applying Thiemo's patch to mark pages
> tainted by PIO IDE as dirty, the lockup still occurs.
> 
> I narrowed the file changes to
> 
>      arch/mips/mm/c-sb1.c
>      arch/mips/mm/cache.c
>      arch/mips/mm/init.c
>      include/asm-mips/cache-flush.h
>      include/asm-mips/page.h
> 
> between 2.6.16.27 and 2.6.16.29.  There was no
> 2.6.16.28 tarball posted on linux-mips.org, so I
> basically brought .27 to .29 until I found the
> offending files.

Please learn about git bisect (git-bisect start; git-bisect good;
git-bisect bad) and use it to isolate the offending commit.


Thiemo
From root@linux-mips.net Wed Mar 26 17:09:36 2008
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 17:09:39 +0100 (CET)
Received: (root@lappi.linux-mips.net) by lappi.linux-mips.net
	id S1100670AbYCZMiY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Mar 2008 13:38:24 +0100
Resent-From: root@lappi.linux-mips.net
Resent-Date: Wed, 26 Mar 2008 13:38:23 +0100
Resent-Message-ID: <20080326123823.GA2581@lappi.linux-mips.net>
Resent-To: linux-mips@linux-mips.org
Received: from oss.sgi.com ([192.48.170.157]:64171 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1096320AbYCZLhr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 12:37:47 +0100
Received: from p549F5321.dip.t-dialin.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2QBVUZi016060
	for <linux-mips@linux-mips.org>; Wed, 26 Mar 2008 04:37:07 -0700
Received: from web38815.mail.mud.yahoo.com ([209.191.125.106]:52659 "HELO
	web38815.mail.mud.yahoo.com") by lappi.linux-mips.net with SMTP
	id S1101128AbYCYNFi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Mar 2008 14:05:38 +0100
Received: (qmail 44851 invoked by uid 60001); 25 Mar 2008 13:05:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=xCBNhWpKinYwWrVvE1Uft9KGjTtZxt3g4fLPn/rjRmDA6K+sN1agoijgRQYs+RIgIIhruDSUXidESuHIwJJ8q05/w71YSGb0eQBTMPTuA0gXFkoooie/8tjkvSWhoLRoN5h3DU151KFKXteS111lV/m/mKh9Gz3fOpXMhQFNPIQ=;
X-YMail-OSG: n7Waq3QVM1l.9KDtAO5iZnkVuqvXgNAognoUnsO_4moP6ISOuUdkSnqDuQ3FVPWwTqPhmQrTxytPdaJySzD.AJtfVyUvj5fRjj_mMOBdPFB.ETj0Xmw-
Received: from [68.236.82.170] by web38815.mail.mud.yahoo.com via HTTP; Tue, 25 Mar 2008 06:05:35 PDT
Date:	Tue, 25 Mar 2008 06:05:35 -0700 (PDT)
From:	Larry Stefani <lstefani@yahoo.com>
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080324203311.GB15294@linux-mips.org>
MIME-Version: 1.0
Content-Type:	text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <64859.43533.qm@web38815.mail.mud.yahoo.com>
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <root@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: root@lappi.linux-mips.net
Precedence: bulk
X-list: linux-mips
Content-Length: 2270
Lines: 70

Hello Ralf,

Thank you very much for the quick response.  I know
you must be terribly busy with the server move, so I
won't take up too much more of your time.

I did find an old (possibly related) discussion you
were involved in:

http://www.linux-mips.org/archives/linux-mips/2006-09/msg00194.html

I can't tell from the thread whether it was a problem
seen on 2.6.16.29, but that might have been tip at the
time.

> It's a bug which should be fixed but nevertheless I
> can highly recommend
> something like a SiliconImage SATA controller - the
> onboard PIO PATA
> controller is so slow.

I understand, but changing that is not an option for
me today.

> I've pushed the tag again so now there is a tarball.

Thanks.  I thought something was terribly wrong with
.28 for it to be skipped.  

> If you need to track something like this you're
> probably best with
> git bisect which should bring you right to the
> offending commit.

I probably should have used that approach instead of
diffing .27 and .29 and narrowing the file list by
hand.  As it was, there were changes to non-MIPS
platforms and devices I'm not using so those were easy
to apply to .27.  Also, there were many file changes
for MT SMP support, and *most* (but not all) of those
changes were wrapped with conditional compiles, so
those were also easy to apply.  I knew once I got to
these five files I was in some interesting code that
could point to the problems I'm seeing.

> Later kernels do run on bcm1480 which is close
> enough.

By "later kernels", do you mean 2.6.16.60 or different
kernel branches?

Perhaps, but I'm seeing identical failures in .29 and
.60, although that could be misleading.  I do see
significant SMP-related changes in c-sb1.c between .29
and .60, and I am running in SMP.  I wish there was an
easy way to know whether it's in the same code.

Anyway, in the interest of time I may revert to .27
which appears to work.  I don't need any of the MT SMP
related changes that followed, and perhaps I can live
without the enhancements between .27 and .60 for now.

Thanks,
Larry Stefani
lstefani@yahoo.com



      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
From rkota@broadcom.com Wed Mar 26 17:28:37 2008
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 17:28:44 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:54696 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1100635AbYCZNEj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 14:04:39 +0100
Received: from p549F5321.dip.t-dialin.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2QBVULO016060
	for <linux-mips@linux-mips.org>; Wed, 26 Mar 2008 06:03:58 -0700
Received: from mms2.broadcom.com ([216.31.210.18]:18962 "EHLO
	mms2.broadcom.com") by lappi.linux-mips.net with ESMTP
	id S1102827AbYCZFV0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 06:21:26 +0100
Received: from [10.10.64.154] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 25 Mar 2008 22:20:45 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 B72B12B1; Tue, 25 Mar 2008 22:20:45 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id A39182B0 for
 <linux-mips@linux-mips.org>; Tue, 25 Mar 2008 22:20:45 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GRH15356; Tue, 25 Mar 2008 22:20:44 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com (nt-sjca-0752
 [10.16.192.222]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 CFACF20501 for <linux-mips@linux-mips.org>; Tue, 25 Mar 2008 22:20:44
 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: MTD Partitions Permissions at Run Time.
Date:	Tue, 25 Mar 2008 22:20:43 -0700
Message-ID: <E06E3B7BBC07864CADE892DAF1EB0FBD0641257D@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <47E7EBFF.6020406@ru.mvista.com>
Thread-Topic: MTD Partitions Permissions at Run Time.
Thread-Index: AciN2LlE4bF7ypqjS4Cg9fHtifqyCABJ9L3g
References: <47E559B6.9010001@ru.mvista.com>
 <47E7EBFF.6020406@ru.mvista.com>
From:	"Ramgopal Kota" <rkota@broadcom.com>
To:	linux-mips@linux-mips.org
X-WSS-ID: 6BF702A741K18759677-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <rkota@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkota@broadcom.com
Precedence: bulk
X-list: linux-mips
Content-Length: 602
Lines: 18

Hi ,

Ours is a embedded product with pre-defined flash partitions say "Boot"
, "Kernel" , "Rootfs" & "ProductData".
The kernel which is in the box (linux 2.6.14)has Boot partition as "RO"
(Read Only). We have a requirement in the field that the boot code
should be upgraded also.
Is there any possibility of changing the partition permissions at
run-time? If so how ? 
Our solution was to create a Kernel image Boot as RW, upgrade the kernel
& reboot. Later change the Boot code.

But we are seeing if we can avoid such situation by remounting the MTD
partition with a RW permission.

Ramgopal Kota
