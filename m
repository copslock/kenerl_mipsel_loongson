Received:  by oss.sgi.com id <S42417AbQI3A1F>;
	Fri, 29 Sep 2000 17:27:05 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.19.53]:17671
        "EHLO u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42392AbQI3A0k>; Fri, 29 Sep 2000 17:26:40 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869537AbQI3AZ1>;
        Sat, 30 Sep 2000 02:25:27 +0200
Date:   Sat, 30 Sep 2000 02:25:27 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     glonnon@ridgerun.com, linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: problems execve("/sbin/init",...)
Message-ID: <20000930022527.C29860@bacchus.dhis.org>
References: <39D3FFE4.35E83599@ridgerun.com> <39D5204A.8BE1E357@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39D5204A.8BE1E357@mvista.com>; from jsun@mvista.com on Fri, Sep 29, 2000 at 04:05:46PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 29, 2000 at 04:05:46PM -0700, Jun Sun wrote:

> I found one bug in arch/mm/r4xx0.c, where cache invalidation causes
> recursive page faults.  See the page below.  Not sure if it is fixed in
> the tree yet.

This bug doesn't affect 2.2 which is the kernel in question.

  Ralf
