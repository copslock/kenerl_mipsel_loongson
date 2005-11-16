Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 02:08:48 +0000 (GMT)
Received: from web30710.mail.mud.yahoo.com ([68.142.200.143]:59290 "HELO
	web30710.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134014AbVKPCIa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 02:08:30 +0000
Received: (qmail 90088 invoked by uid 60001); 16 Nov 2005 02:10:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uD6qIzSM/K8GePK80FTkXxVvJ6ffjqSGX26SJV+qXr2WVvn9KcqCqIT6lwoLHsT+cMuMAbhautt5jmFy564N8gGT/uYZGmek1nJqdPxuY1TG8Y/WgalyxCpWDP1IGHy0hqUJWA1SPIH1A6XIE93QpNXTLjev9R+wofRa1VzUVnE=  ;
Message-ID: <20051116021026.90086.qmail@web30710.mail.mud.yahoo.com>
Received: from [203.190.168.9] by web30710.mail.mud.yahoo.com via HTTP; Wed, 16 Nov 2005 02:10:26 GMT
Date:	Wed, 16 Nov 2005 02:10:26 +0000 (GMT)
From:	Nguyen Thanh Binh <n_tbinh@yahoo.com>
Subject: Re: Calibrating delay loop... crashes
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <437A8FA1.8010404@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <n_tbinh@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n_tbinh@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Kevin,

> > When booting Monta Vista Linux on Memec board
> > (Virtex-4 FX12 LC), it crashed after printing the
> > following message:
> > 
> >     "Calibrating delay loop..."
> > 
> > By looking at the source code, I found that in the
> > init/main.c the problem came from the
> calibrate_delay
> > function: jiffies was not incremented (jiffies was
> > always equal to 0).
> > 
> > Have anyone get the similar problem or any
> experience
> > to fix it?
> 
> I take it that by "crashed", you mean it hung?  If
> so,
> it sounds like you aren't getting any timer
> interrupts.

You are right. Because jiffies was not incremented so
the below code segment in function calibrate_delay in
file init/mian.c hung:

   ticks = jiffies;
   while (ticks == jiffies) ;

As I am a newbie, I did not find how to fix it.

Thank you for any help.

Binh Nguyen

Nguy&#7877;n Thanh Bình


		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
