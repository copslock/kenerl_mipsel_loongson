Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2003 13:55:50 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:57785
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225235AbTFCMzq>; Tue, 3 Jun 2003 13:55:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id EC82D2BC36
	for <linux-mips@linux-mips.org>; Tue,  3 Jun 2003 14:55:43 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 12483-10
 for <linux-mips@linux-mips.org>; Tue,  3 Jun 2003 14:55:43 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id EC5352BC34
	for <linux-mips@linux-mips.org>; Tue,  3 Jun 2003 14:55:42 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 58EDD17762; Tue,  3 Jun 2003 14:55:36 +0200 (CEST)
Date: Tue, 3 Jun 2003 14:55:36 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: rootfs for vr4181a
Message-ID: <20030603125536.GB19435@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <200306031428.48675.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306031428.48675.julian@jusst.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 03, 2003 at 02:28:48PM +0200, Julian Scheel wrote:
> I am searching for a rootfs which can be used with a NEC VR4181A and can be 
> mounted over NFS (shouldn't need any special things, should it?)
> Has someone such a rootfs - or can give me a link where to find it - or a link 
> to a description how to do it myself?
You can try for mips:
http://debian.physik.uni-konstanz.de/debian/dists/woody/main/disks-mips/3.0.23-2002-05-21/root.tar.gz
or for mipsel:
http://debian.physik.uni-konstanz.de/debian/dists/woody/main/disks-mipsel/3.0.23-2002-05-21/root.tar.gz
(or any other debian mirror) for a rather minimal rootfs. You can build
a more complete nfs-root by following the steps in the installer.
Regards,
 -- Guido
