Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2006 10:23:29 +0200 (CEST)
Received: from wx-out-0102.google.com ([66.249.82.206]:65261 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133372AbWE2IXV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2006 10:23:21 +0200
Received: by wx-out-0102.google.com with SMTP id t5so335389wxc
        for <linux-mips@linux-mips.org>; Mon, 29 May 2006 01:23:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U4FNZtMOl2QZm1+CGQNW4lm+a3dIE6k5Yg647RJfFZo4gfJrxuIXLwTvrJYsBX05YwCljqUb9MZU5nPe+7OdM9ttZP33ADOAnXAIg5rqixL0a+iFObPGF2HHx422Vje6hLi3Y/578dtafDVukIC+X5m/Z4p6mbZLwRKE8dTgzbY=
Received: by 10.70.96.4 with SMTP id t4mr2026022wxb;
        Mon, 29 May 2006 01:23:15 -0700 (PDT)
Received: by 10.70.118.5 with HTTP; Mon, 29 May 2006 01:23:15 -0700 (PDT)
Message-ID: <d096a3ee0605290123g7169e430t17ea1fb8bd9e7627@mail.gmail.com>
Date:	Mon, 29 May 2006 13:53:15 +0530
From:	"Mayuresh Chitale" <mchitale@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: oprofile for mips 24k
In-Reply-To: <20060529.154457.27952799.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <d096a3ee0605282258y210244c7sbdf994d8c075a5e@mail.gmail.com>
	 <20060529.154457.27952799.nemoto@toshiba-tops.co.jp>
Return-Path: <mchitale@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchitale@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

The output of kill -l seems to be proper.
for eg. kill -l USR1 returns value of 16 which looks like the correct
value for mips.

Thanks,
Mayuresh.

On 5/29/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 29 May 2006 11:28:06 +0530, "Mayuresh Chitale" <mchitale@gmail.com> wrote:
> > But ps -aef shows oprofiled is not running.
> > # ps -aef
> ...
> >
> > Do we need to do some additional setup / init to get this working?
> > Any experience/suggestion is welcome.
>
> The oprofile requires bash.  If you were cross-compiling bash, please
> check output of "kill -l".  If bash was not correctly cross-compiled,
> a value of some signals might be wrong (ex. signal 10 is SIGUSR1 on
> i386 but SIGBUS on MIPS).  The opcontrol send SIGUSR1/SIGUSR2 to
> oprofiled.
>
> ---
> Atsushi Nemoto
>
