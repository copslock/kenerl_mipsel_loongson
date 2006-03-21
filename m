Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2006 13:05:04 +0000 (GMT)
Received: from mf2.realtek.com.tw ([60.248.182.46]:11795 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133441AbWCUNE0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Mar 2006 13:04:26 +0000
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T772b139be9dc8038161bb4@mf2.realtek.com.tw>;
 Tue, 21 Mar 2006 21:16:53 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2006032121140678-150808 ;
          Tue, 21 Mar 2006 21:14:06 +0800 
Message-ID: <00a101c64ce9$554b3180$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <009101c64ce4$72d78820$106215ac@realtek.com.tw> <20060321125255.GA8779@linux-mips.org>
Subject: Re: uptime is too high. Is it normal?
Date:	Tue, 21 Mar 2006 21:14:06 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/21 =?Bog5?B?pFWkyCAwOToxNDowNg==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/21 =?Bog5?B?pFWkyCAwOToxNDowOQ==?=,
	Serialize complete at 2006/03/21 =?Bog5?B?pFWkyCAwOToxNDowOQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi Ralf,
Here is the result:

/usr/local/bin # ps -aux
  PID  Uid     VmSize Stat Command
    1 root        412 S   init
    2 root            SWN [ksoftirqd/0]
    3 root            SW< [events/0]
    4 root            SW< [khelper]
    5 root            SW< [kthread]
    6 root            SW< [kblockd/0]
    9 root            SW  [khubd]
   36 root            SW  [pdflush]
   37 root            SW  [pdflush]
   39 root            SW< [aio/0]
   38 root            SW  [kswapd0]
  645 root            SW  [645]
  646 root            DW  [646]
  647 root            DW  [647]
  648 root            SW  [648]
  649 root            SW  [mtdblockd]
  666 root            SW  [kjournald]
  680 root        380 S   /sbin/syslogd -p /tmp/.log -n -m 0
  681 root        348 S   /sbin/klogd -n
  753 root        400 S   inetd
  793 root        572 S   -sh
  794 root        416 S   init
  811 root        416 S   init
  822 root        416 S   init
  980 root            SW< [rpciod/0]
 1015 root        396 R   ps -aux
/usr/local/bin # uptime
 00:19:29 up 19 min, load average: 2.00, 1.95, 1.41

The uptime value keeps on going higher and higher.
It seems that both 646 & 647 process has the same parent "1".
Their "utime" are "0".

Thanks and regards,
Colin


----- Original Message ----- 
From: "Ralf Baechle" <ralf@linux-mips.org>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-mips@linux-mips.org>
Sent: Tuesday, March 21, 2006 8:52 PM
Subject: Re: uptime is too high. Is it normal?


> On Tue, Mar 21, 2006 at 08:39:08PM +0800, colin wrote:
>
> > Hi all,
> > We use MIPS Linux+uClibc0.9.28+busybox 1.1.0 on our machine.
> > After use "uptime" to get the loading of device, it shows:
> >     03:50:05 up  3:50, load average: 2.00, 2.00, 2.00
> > Is it normal? It seems too high because my PC Linux has a much lower
value:
> >     20:38:31 up 12 days,  5:11,  5 users,  load average: 0.04, 0.01,
0.00
>
> Well, check with ps what is causing the load.  Look for processes in
> either 'D' or 'R' state.
>
>   Ralf
