Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 03:07:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57321 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133856AbWGZCH3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2006 03:07:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k6Q27KHV025914;
	Tue, 25 Jul 2006 22:07:20 -0400
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k6Q27KDc025913;
	Tue, 25 Jul 2006 22:07:20 -0400
Date:	Tue, 25 Jul 2006 22:07:20 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chad Reese <creese@caviumnetworks.com.redhat.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 64bit kernel/N32 userspace - shmctl corrupts userspace memory
Message-ID: <20060726020720.GB21024@linux-mips.org>
References: <44C6B829.8050508@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C6B829.8050508@caviumnetworks.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 25, 2006 at 05:32:41PM -0700, Chad Reese wrote:

> If you're running a 64bit kernel with N32 userspace, shmctl will corrupt
> memory in userspace. When copy_shmid_to_user() is called, it copies the
> entire kernel shmid_ds into userspace. For a 64bit kernel, this is 88
> bytes. In N32 userspace it is 76 bytes.
> 
> My hack to get around the problem is attached, but I expect someone here
> will be able to come up with a better fix. shmid_ds contains a lot of
> members that are marked unused. Are these really useless?

They need to be there for compatibility with older revisions of the
structure - we can increase the size of the structure but not decrease.

Talking about compatibility, you change breaks N64 compatibility ...

  Ralf
