Received:  by oss.sgi.com id <S42353AbQHWUBQ>;
	Wed, 23 Aug 2000 13:01:16 -0700
Received: from sgigate.SGI.COM ([204.94.209.1]:2091 "EHLO gate-sgigate.sgi.com")
	by oss.sgi.com with ESMTP id <S42333AbQHWUAn>;
	Wed, 23 Aug 2000 13:00:43 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868972AbQHWT45>;
        Wed, 23 Aug 2000 12:56:57 -0700
Date:   Wed, 23 Aug 2000 12:56:57 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Kanoj Sarcar <kanoj@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000823125657.A1008@bacchus.dhis.org>
References: <20000823172400Z42326-31375+197@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000823172400Z42326-31375+197@oss.sgi.com>; from kanoj@oss.sgi.com on Wed, Aug 23, 2000 at 10:23:50AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Aug 23, 2000 at 10:23:50AM -0700, Kanoj Sarcar wrote:

> Log message:
> 	Make prom_printf() functional on IP27s. And prom_printf() is not an
> 	init function, it needs to be around during regular system usage.

On my system after the first TLB flush all PROM functions are no longer
usable since the function pointer point to mapped space.  Similar for
other ARC machines.

  Ralf
