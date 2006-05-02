Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 08:20:12 +0100 (BST)
Received: from web25811.mail.ukl.yahoo.com ([217.146.176.244]:65442 "HELO
	web25811.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133408AbWEBHUB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 08:20:01 +0100
Received: (qmail 44640 invoked by uid 60001); 2 May 2006 07:19:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=2iKUVKnnio8la8F9feZsOI6xYjSXzocgnEdyRayzG38LAjtd+qRCMK9RUJj5qWQS98/WuVNiBFOlWe9VTjFGNtfDQf3wxhEe+OitrDc28eTkRLDxsJZOTE4DNyaeeqYgEWatCg+ttUZuHFurknuasrqrvsxA8nQI9S2e9Q10ze4=  ;
Message-ID: <20060502071949.44638.qmail@web25811.mail.ukl.yahoo.com>
Date:	Tue, 2 May 2006 07:19:49 +0000 (GMT)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : module allocation
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060428200307.GA17705@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

> There is another reason against putting modules into mapped space and
> that's the need for -mlong-calls which generates larger, less efficient
> code.

BTW, I don't see why -mlong-calls wouldn't be needed for GFP module
allocation. Can you explain ?

Thanks
