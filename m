Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IKqau26129
	for linux-mips-outgoing; Mon, 18 Jun 2001 13:52:36 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IKqNV26109;
	Mon, 18 Jun 2001 13:52:23 -0700
Received: from [171.69.113.18] (earth.ayrnetworks.com [10.1.1.24])
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f5IKp8312155;
	Mon, 18 Jun 2001 13:51:08 -0700
User-Agent: Microsoft-Entourage/9.0.2509
Date: Mon, 18 Jun 2001 14:52:32 -0600
Subject: Re: Profiling support in glibc?
From: Greg Satz <satz@ayrnetworks.com>
To: Ralf Baechle <ralf@oss.sgi.com>, Brian Murphy <brian@murphy.dk>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Message-ID: <B753C62F.5AA5%satz@ayrnetworks.com>
In-Reply-To: <20010618222554.B26781@bacchus.dhis.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Oddly enough I didn't have to make any changes to gprof. I used the version
in binutils-2.11.90.0.1.

Thanks,
Greg

on 6/18/01 2:25 PM, Ralf Baechle at ralf@oss.sgi.com wrote:

> The other issue is of course gprof ...
