Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBF0NSH13107
	for linux-mips-outgoing; Fri, 14 Dec 2001 16:23:28 -0800
Received: from buzz.ichilton.co.uk (pc3-stoc4-0-cust138.mid.cable.ntl.com [213.107.175.138])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBF0NPo13104
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 16:23:25 -0800
Received: by buzz.ichilton.co.uk (Postfix, from userid 100)
	id 19FD21CE3B9; Fri, 14 Dec 2001 23:23:21 +0000 (GMT)
Date: Fri, 14 Dec 2001 23:23:21 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Florian Lohoff <flo@rfc822.org>
Cc: agx@sigxcpu.org, linux-mips@oss.sgi.com
Subject: Re: Current CVS on Indigo2 fail
Message-ID: <20011214232321.A1982@buzz.ichilton.local>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20011213123522.GA32232@paradigm.rfc822.org> <20011213135229.C14699@gandalf.physik.uni-konstanz.de> <20011213134827.GA5630@paradigm.rfc822.org> <20011213150622.A13394@galadriel.physik.uni-konstanz.de> <20011213171043.GD25296@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213171043.GD25296@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> It solved the issue ... Here is the patch against current cvs

I sync'd with cvs and tried to apply this patch and it failed.

Without the patch, the kernel doesn't work on my I2:

Command Monitor.  Type "exit" to return to the menu.                            
>> bootp():/vmlinux                                                             
Setting $netaddr to 192.168.0.13 (from server )                                 
Obtaining /vmlinux from server                                                  
  |                            

[hangs here]


Bye for Now,

Ian
