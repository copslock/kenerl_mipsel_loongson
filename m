Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2006 10:31:48 +0100 (BST)
Received: from ingenieursbureauknipscheer.nl ([213.189.19.79]:42493 "EHLO
	mail.kpsws.com") by ftp.linux-mips.org with ESMTP id S8133539AbWGUJbk
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Jul 2006 10:31:40 +0100
Received: (qmail 99299 invoked by uid 89); 21 Jul 2006 09:28:08 -0000
Received: from unknown (HELO mail.kpsws.com) (127.0.0.1)
  by 127.0.0.1 with SMTP; 21 Jul 2006 09:28:08 -0000
Received: from 194.171.252.100
        (SquirrelMail authenticated user pulsar@kpsws.com)
        by mail.kpsws.com with HTTP;
        Fri, 21 Jul 2006 09:28:08 -0000 (UTC)
Message-ID: <15360.194.171.252.100.1153474088.squirrel@mail.kpsws.com>
In-Reply-To: <20060720191836.GA22361@linux-mips.org>
References: <1153414322.20352.268.camel@sakura.staff.proxad.net>
    <20060720191836.GA22361@linux-mips.org>
Date:	Fri, 21 Jul 2006 09:28:08 -0000 (UTC)
Subject: reserved pages and zero pages question
From:	pulsar@kpsws.com
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <pulsar@kpsws.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pulsar@kpsws.com
Precedence: bulk
X-list: linux-mips

Hi,

In my kernel startup I see the memory usage printed as:

Memory: 125312k/131072k available (1977k kernel code, 5648k reserved, 287k
data, 1664k init, 0k highmem)

I wonder where the reserved pages are used for and how we can minimize it
for small memory systems.

In my search I see that in arcm/mips/mm/init.c there are zero-pages
allocated and put to reserved.

Where are the zero pages used for and can we do without ?

thanks in advance,

Niels Sterrenburg
