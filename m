Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QGD2x23292
	for linux-mips-outgoing; Fri, 26 Oct 2001 09:13:02 -0700
Received: from web11908.mail.yahoo.com (web11908.mail.yahoo.com [216.136.172.192])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QGCx023288
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 09:12:59 -0700
Message-ID: <20011026161259.54925.qmail@web11908.mail.yahoo.com>
Received: from [209.243.184.191] by web11908.mail.yahoo.com via HTTP; Fri, 26 Oct 2001 09:12:59 PDT
Date: Fri, 26 Oct 2001 09:12:59 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Backspace on Virtual Console causes oops
To: linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1011019152309.1657F-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear All,

I am having a problem with the backspace key on a
virtual terminal on a 2.4.2 kernel. If I hit backspace
when there is input at the command line - no problem
it deletes the character before the cursor.
But if I press backspace when there are no characters
at the command prompt, the kernel throws an oops. The
process causing the oops is Bash.
Note, on the Serial console, backspace works fine all
the time.

Has anyone ever seen anything like this ? If you have
how did you solve it ?

Does anyone know the program flow / program details of
what happens when backspace is pressed eg :

    Key In > Key passed to Routine X > Routine X
passes it to Routine Y etc > Bash receives key.

Or could someone point me to a doc that may explain
this ?

Thx

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
