Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QI77g32274
	for linux-mips-outgoing; Fri, 26 Oct 2001 11:07:07 -0700
Received: from pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QI73032271
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 11:07:03 -0700
Received: from adsl.pacbell.net ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GLT003MSRN6KC@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Fri, 26 Oct 2001 11:07:01 -0700 (PDT)
Date: Fri, 26 Oct 2001 11:05:42 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: Backspace on Virtual Console causes oops
In-reply-to: <20011026161259.54925.qmail@web11908.mail.yahoo.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Message-id: <1004119562.14540.3.camel@adsl.pacbell.net>
MIME-version: 1.0
X-Mailer: Evolution/0.16.99+cvs.2001.10.22.19.12 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20011026161259.54925.qmail@web11908.mail.yahoo.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-10-26 at 09:12, Wayne Gowcher wrote:
> Dear All,
> 
> I am having a problem with the backspace key on a
> virtual terminal on a 2.4.2 kernel. If I hit backspace
> when there is input at the command line - no problem
> it deletes the character before the cursor.
> But if I press backspace when there are no characters
> at the command prompt, the kernel throws an oops. The
> process causing the oops is Bash.
> Note, on the Serial console, backspace works fine all
> the time.

I'll make a guess.  With no input at the line, when you hit backspace,
the shell is probably generating a beep.  Your kernel is not handling
that.  I don't remember exactly where the "beep code" was but you can
probably find it pretty quickly.

Pete

> 
> Has anyone ever seen anything like this ? If you have
> how did you solve it ?
> 
> Does anyone know the program flow / program details of
> what happens when backspace is pressed eg :
> 
>     Key In > Key passed to Routine X > Routine X
> passes it to Routine Y etc > Bash receives key.
> 
> Or could someone point me to a doc that may explain
> this ?
> 
> Thx
> 
> __________________________________________________
> Do You Yahoo!?
> Make a great connection at Yahoo! Personals.
> http://personals.yahoo.com
