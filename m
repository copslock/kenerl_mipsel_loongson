Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CGuO8d011641
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 09:56:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CGuORN011640
	for linux-mips-outgoing; Fri, 12 Apr 2002 09:56:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dell.lineo.com ([212.74.13.151])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CGuK8d011637
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 09:56:21 -0700
Received: from zentropix.com (localhost.localdomain [127.0.0.1])
	by dell.lineo.com (8.11.6/8.11.6) with ESMTP id g3CGujC19989;
	Fri, 12 Apr 2002 17:56:49 +0100
Message-ID: <3CB711CD.83F65C13@zentropix.com>
Date: Fri, 12 Apr 2002 17:56:45 +0100
From: Stuart Hughes <stuarth@zentropix.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Scott A McConnell <samcconn@cotw.com>
CC: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped?
References: <3CB71C48.B768A40D@cotw.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Scott A McConnell wrote:
> 
> For my vr5432 based board (2.4.5) I can strip and run executables.
> 
> If I strip a module, insmod dies in obj_load() with Floating point
> exception.
> 
> Has anyone else seen this?

Yep,

Be careful what you strip.  I found the safest thing was to use 'strip
-g'
-- 
Regards, Stuart Hughes
