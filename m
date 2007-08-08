Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 11:31:32 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40859 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026855AbXHHKba (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 11:31:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l78AVJ9B005935;
	Wed, 8 Aug 2007 11:31:19 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l78AVJqe005934;
	Wed, 8 Aug 2007 11:31:19 +0100
Date:	Wed, 8 Aug 2007 11:31:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems with NFS boot
Message-ID: <20070808103119.GB5622@linux-mips.org>
References: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 08, 2007 at 12:18:51PM +0200, Mohamed Bamakhrama wrote:

> Hi list,
> I have a Malta board for which I was able to build the kernel, load it
> and start it. The problem comes when it tries to boot through the NFS.
> 
> I start the kernel with the following command:
> go . nfsroot=192.168.1.1/mnt/danube_rootfs ip=192.168.1.4:192.168.1.1:::
                         ^^ there should be a `:' following the IP.

  Ralf
