Received:  by oss.sgi.com id <S554120AbRAZVUh>;
	Fri, 26 Jan 2001 13:20:37 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:10364 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S554116AbRAZVU2>;
	Fri, 26 Jan 2001 13:20:28 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03796
	for <linux-mips@oss.sgi.com>; Fri, 26 Jan 2001 13:20:27 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869667AbRAZVQ7>; Fri, 26 Jan 2001 13:16:59 -0800
Date: 	Fri, 26 Jan 2001 13:16:59 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Joe deBlaquiere <jadb@redhat.com>
Cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010126131659.I869@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010126111156.8903B-100000@delta.ds2.pg.gda.pl> <3A719ABD.5030206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A719ABD.5030206@redhat.com>; from jadb@redhat.com on Fri, Jan 26, 2001 at 09:41:49AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 09:41:49AM -0600, Joe deBlaquiere wrote:

> 		sys_munlock(p,sizeof(*p));

> 
> comments anyone?

Mlock(2) doesn't nest.  So if the page was mlocked before, you just unlocked
it.

  Ralf
