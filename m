Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g02LVZU25312
	for linux-mips-outgoing; Wed, 2 Jan 2002 13:31:35 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g02LVVg25308
	for <linux-mips@oss.sgi.com>; Wed, 2 Jan 2002 13:31:31 -0800
Received: from [192.168.1.241] (192.168.1.241 [192.168.1.241]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id ZA0NHPNL; Wed, 2 Jan 2002 15:31:23 -0500
Subject: Re: general linux question
From: Marc Karasek <marc_karasek@ivivity.com>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA1B74D9@ATVX>
References: <7DF7BFDC95ECD411B4010090278A44CA1B74D9@ATVX>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.13.08.57 (Preview Release)
Date: 02 Jan 2002 15:30:26 -0500
Message-Id: <1010003431.1088.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You could embed a header into the file itself that is lart of the linker
directive file.  These variables would be available from w/i the
program.  They are kinda like global variables.  The version could then
be tracked thru this file.  You can use things like compile date/time
etc. Each time you recompile the variables would change. 

On Wed, 2002-01-02 at 12:36, Siders, Keith wrote:
> This isn't mips-specific, so maybe belongs on another list, but I figured
> someone here could probably answer just as quickly. I need to track versions
> of all files in the system (embedded, flash-based, no disk media), but
> cannot find a structure member where a version number can be stored in a
> file header. Most linux command line apps generally have a -version command
> line option, but is not viable for our application. Have I missed something?
> Is there a standard Linux method/practice for version number tracking and
> retrieval that is separate from CVS and the -version command switch, or do I
> have to use something proprietary? Or should I just try to use the file
> creation timestamp?
> 
> Keith Siders
> Software Engineer
>  Toshiba America Consumer Products, Inc.
> Advanced Television Technology Center
> 801 Royal Parkway, Suite 100
> Nashville, Tennessee 37214
> Phone: (615) 257-4050
> Fax:   (615) 453-7880
-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
