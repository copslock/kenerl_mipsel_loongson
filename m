Received:  by oss.sgi.com id <S554086AbRAQP1c>;
	Wed, 17 Jan 2001 07:27:32 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:7438 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S554083AbRAQP11>; Wed, 17 Jan 2001 07:27:27 -0800
Received: from frodo.physik.uni-konstanz.de [134.34.144.82] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14IuUd-0004BM-00; Wed, 17 Jan 2001 16:27:23 +0100
Received: from agx by frodo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14IuUZ-0000dr-00; Wed, 17 Jan 2001 16:27:19 +0100
Date:   Wed, 17 Jan 2001 16:27:18 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20010117162718.A2447@frodo.physik.uni-konstanz.de>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de> <20010117154937.C2517@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117154937.C2517@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Jan 17, 2001 at 03:49:37PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 03:49:37PM +0100, Florian Lohoff wrote:
> I set this in the prom:
> 
> OSLoadFilename=vmlinux
> OSLoadPartition=/dev/sda1
> OSLoader=vmlinux
> SystemPartition=scsi(1)disk(4)rdisk(0)partition(0)
No need to set OSLoadFilename, OSLoader should be sufficient. Could you
try to use SystemPartition=...partition(8)? Since this is the partition
number of the volume header AFAIR.
 -- Guido 
