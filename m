Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HHnrA08055
	for linux-mips-outgoing; Fri, 17 Aug 2001 10:49:53 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HHnpj08052
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 10:49:51 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7HHsVA08494;
	Fri, 17 Aug 2001 10:54:31 -0700
Message-ID: <3B7D57E4.D7B14D63@mvista.com>
Date: Fri, 17 Aug 2001 10:44:04 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hua Wen <wenh@taec.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Upgrade kernel from release 2.2 to 2.4.?
References: <Pine.SOL.4.31.0105061221330.1956-100000@fury.csh.rit.edu> <3B7D5513.F10F35A1@taec.com>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hua Wen wrote:
> 
> Hi,
> 
> We made changes to linux/MIPS kernel 2.2.1 for our
> system and it's been running well so far. We now
> plan to upgrade the kernel to 2.4.X. The question
> is:
> 
> Which sub release of 2.4 is more stable and is
> recommended to use?
> 
> From http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux,
> I can see available tags for kernel 2.4 are:
> linux_2_4_4, linux_2_4_3, linux_2_4_2,
> linux_2_4_0...
> 
> Thanks in advance for your advice!
> 
> -Hua

I suggest you use the latest CVS head.  So far it is usually the head that has
the most bug fixes, and really not much dramatic stuff introduced.

Jun
