Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA6L9D013070
	for linux-mips-outgoing; Tue, 6 Nov 2001 13:09:13 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fA6L9C013067
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 13:09:12 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA6L8dn30589;
	Tue, 6 Nov 2001 13:08:39 -0800
Date: Tue, 6 Nov 2001 13:08:39 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
Message-ID: <20011106130839.B30219@dea.linux-mips.net>
References: <013301c165cc$5d030fa0$4a1c690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <013301c165cc$5d030fa0$4a1c690a@huawei.com>; from dony.he@huawei.com on Mon, Nov 05, 2001 at 03:34:44PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 05, 2001 at 03:34:44PM +0800, machael wrote:

>     I use linux-2.4.5 and I think VMALLOC may have some bugs which i don't
> know how to fixup.

Vmalloc is probably innocent I'd rather guess cache flushing is broken on
your platform.

  Ralf
