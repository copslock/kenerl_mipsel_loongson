Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2003 23:17:46 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:22116 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225227AbTEGWRo>;
	Wed, 7 May 2003 23:17:44 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id 51AEA7DC; Thu,  8 May 2003 00:17:18 +0200 (CEST)
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] sc-ip22.c cleanup
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030507202229.GA627@kopretinka> (Ladislav Michl's message of
 "Wed, 7 May 2003 22:22:29 +0200")
References: <20030507202229.GA627@kopretinka>
Date: Thu, 08 May 2003 00:17:18 +0200
Message-ID: <8665oml7v5.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ladis" == Ladislav Michl <ladis@linux-mips.org> writes:

Hi

ladis> +	unsigned long size = ip22_eeprom_read(&sgimc->eeprom, 17);

Defining somewhere what 17 mean could be a good idea :)

Except for that looks like a good gain, you remove a lot fo code :)

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
