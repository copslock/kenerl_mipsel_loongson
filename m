Received:  by oss.sgi.com id <S553853AbRAZHqn>;
	Thu, 25 Jan 2001 23:46:43 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:19735 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553792AbRAZHqb>;
	Thu, 25 Jan 2001 23:46:31 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com (dhcp-163-154-5-240.engr.sgi.com [163.154.5.240]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id XAA00449
	for <linux-mips@oss.sgi.com>; Thu, 25 Jan 2001 23:45:33 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870759AbRAZHnN>; Thu, 25 Jan 2001 23:43:13 -0800
Date: 	Thu, 25 Jan 2001 23:43:03 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     Michael Shmulevich <michaels@jungo.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
Message-ID: <20010125234303.G3512@bacchus.dhis.org>
References: <3A70A356.F3CA71F1@jungo.com> <20010125141632.B2311@bacchus.dhis.org> <3A712A52.FAC574F1@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A712A52.FAC574F1@mips.com>; from carstenl@mips.com on Fri, Jan 26, 2001 at 08:42:10AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 08:42:10AM +0100, Carsten Langgaard wrote:

> The tulip driver worked fine at least in the past. The AMD PCnet driver works
> just fine, we are using it on our reference boards.

The biggest grief I had was that about every embedded system I ever had
uses violates the common standard for what is supposed to be in the
EEPROMs of the Tulip or simply doesn't have one at all ...

  Ralf
