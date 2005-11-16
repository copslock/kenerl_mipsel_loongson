Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 02:23:02 +0000 (GMT)
Received: from web30904.mail.mud.yahoo.com ([68.142.200.157]:50527 "HELO
	web30904.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134011AbVKPCWo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 02:22:44 +0000
Received: (qmail 44083 invoked by uid 60001); 16 Nov 2005 02:24:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=P7vFvkPNXgY+QP5vTIfYAYmSsgMUfS8NxN1fW5Og6AGWbLW9i8P+HK2lSg42egnMZmuGtEIr3U6/Ul7JGcxz/DfUgmSGQU9HW9PPqVdV6aXjbDYQXsARwv1ieT0fJe/ve7b8qyPD0RViRa+B+t06xPf3YLKnBRzwB/tSX1XaRR0=  ;
Message-ID: <20051116022439.44081.qmail@web30904.mail.mud.yahoo.com>
Received: from [12.44.186.158] by web30904.mail.mud.yahoo.com via HTTP; Tue, 15 Nov 2005 18:24:39 PST
Date:	Tue, 15 Nov 2005 18:24:39 -0800 (PST)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: Calibrating delay loop... crashes
To:	Nguyen Thanh Binh <n_tbinh@yahoo.com>,
	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051116021026.90086.qmail@web30710.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi !

There is a porting guide at:

http://linux.junsun.net/porting-howto/

which is quite useful. Read the "System time and
timer" section. It describes to some extent
implementing timer services.

Thanks
Manish Lachwani



--- Nguyen Thanh Binh <n_tbinh@yahoo.com> wrote:

> Hi Kevin,
> 
> > > When booting Monta Vista Linux on Memec board
> > > (Virtex-4 FX12 LC), it crashed after printing
> the
> > > following message:
> > > 
> > >     "Calibrating delay loop..."
> > > 
> > > By looking at the source code, I found that in
> the
> > > init/main.c the problem came from the
> > calibrate_delay
> > > function: jiffies was not incremented (jiffies
> was
> > > always equal to 0).
> > > 
> > > Have anyone get the similar problem or any
> > experience
> > > to fix it?
> > 
> > I take it that by "crashed", you mean it hung?  If
> > so,
> > it sounds like you aren't getting any timer
> > interrupts.
> 
> You are right. Because jiffies was not incremented
> so
> the below code segment in function calibrate_delay
> in
> file init/mian.c hung:
> 
>    ticks = jiffies;
>    while (ticks == jiffies) ;
> 
> As I am a newbie, I did not find how to fix it.
> 
> Thank you for any help.
> 
> Binh Nguyen
> 
> Nguy&#7877;n Thanh Bình
> 
> 
> 		
>
___________________________________________________________
> 
> How much free photo storage do you get? Store your
> holiday 
> snaps for FREE with Yahoo! Photos
> http://uk.photos.yahoo.com
> 
> 
