Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 16:37:03 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55253 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490949Ab0GEOg7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 16:36:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o65Eav3H003089;
        Mon, 5 Jul 2010 15:36:58 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o65EatAA003088;
        Mon, 5 Jul 2010 15:36:55 +0100
Date:   Mon, 5 Jul 2010 15:36:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     adnan iqbal <adnan.iqbal@seecs.edu.pk>
Cc:     linux-mips@linux-mips.org
Subject: Re: Issue with RLIMIT Identifiers
Message-ID: <20100705143655.GA3035@linux-mips.org>
References: <AANLkTilZw7Zc9kfZzd-Xle7W3lHN9MSRaXQjv3SQNafj@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTilZw7Zc9kfZzd-Xle7W3lHN9MSRaXQjv3SQNafj@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2010 at 10:27:32AM +0500, adnan iqbal wrote:

> In the file /usr/local/asm-generic.h , RLIMIT_NOFILE   is defined to be
> equal to 7.
> 
> In
> /usr/local/Cavium_Networks/OCTEON-SDK/tools/usr/include/asm/resource.h:#define
> RLIMIT_NOFILE         5
> 
> In
> /usr/local/Cavium_Networks/OCTEON-SDK/tools/usr/include/asm-generic/resource.h:#
> define RLIMIT_NOFILE                7
> i have confirmed through C program that the operating system is using
> RLIMIT_NOFILE=5. I need help to figure out which header files are actually
> being used by the kernel to get exact Resource Identifier.

The non-generic definition, that is RLIMIT_NOFILE is defined as 5.

  Ralf
