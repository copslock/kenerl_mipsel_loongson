Received:  by oss.sgi.com id <S553982AbRA1CzY>;
	Sat, 27 Jan 2001 18:55:24 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:54534 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S553953AbRA1CzK>;
	Sat, 27 Jan 2001 18:55:10 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01884
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 18:55:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870783AbRA0TZ5>; Sat, 27 Jan 2001 11:25:57 -0800
Date: 	Sat, 27 Jan 2001 11:25:56 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Michael Shmulevich <michaels@jungo.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
Message-ID: <20010127112556.K867@bacchus.dhis.org>
References: <3A70A356.F3CA71F1@jungo.com> <20010126115310.D9325@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126115310.D9325@mvista.com>; from jsun@mvista.com on Fri, Jan 26, 2001 at 11:53:10AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 11:53:10AM -0800, Jun Sun wrote:

> 2) set rx_copybreak to 1518 to avoid some cache problem.

Now I wonder changing rx_copybreak is supposed to fix a cache problem?
This sounds broken ...

  Ralf
