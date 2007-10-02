Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 21:41:49 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.184]:21971 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023078AbXJBUlj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 21:41:39 +0100
Received: by fk-out-0910.google.com with SMTP id f40so4292502fka
        for <linux-mips@linux-mips.org>; Tue, 02 Oct 2007 13:41:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=2s0FBm7boKqIqrmxJG+LhChC1OOrUoPRgmDNf27IYWw=;
        b=fdm5Oy4qjiHi3nimyixydx8LIP37N/sGXWpikrNB+rYcI/94hCbPQN0d9jeuSsbERC8pNsZ2IeoUAeYXAI4YBnemh+PE0twnny06fJm3XvUbkXie/Fnxoxp1LpcPcuyKxNpsPaTIaldfEFRlkJ08W60eytb+zkOSIifddsaBEDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=odnS2l3aecbNXw2FL9N4zZJ3Fpqv0UyA5EsuKbYjeKZ3yOKxLma0H+8AYo/oSn2S/EcDYyN7L93/I9MGAexTA4KVxVqSx+wGCXdF3HYN2EZykCznPjCBLnAjuGM094cW0zOjPTNv2NTn1EB5GsrPH5aD0aw203Y581f5tEka2n8=
Received: by 10.82.189.6 with SMTP id m6mr11803830buf.1191357681235;
        Tue, 02 Oct 2007 13:41:21 -0700 (PDT)
Received: by 10.141.129.12 with HTTP; Tue, 2 Oct 2007 13:41:21 -0700 (PDT)
Message-ID: <41370a610710021341g749742dejec06b3a38477fd47@mail.gmail.com>
Date:	Tue, 2 Oct 2007 15:41:21 -0500
From:	"Ed Stafford" <ed.stafford@gmail.com>
To:	linux-mips@linux-mips.org
Subject: What is the current state of the Octane/IP30 support?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <ed.stafford@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ed.stafford@gmail.com
Precedence: bulk
X-list: linux-mips

I have a single-proc Octane at home that I've decided should be
running with Linux, but I have been reading up online about the
Experimental nature of the kernel in relation to the hardware.  Since
most of the info I found was dated 2006, I wanted to ask your (as a
group) opinion on how stable / usable the Octane is today with the
current kernel.

I'm not adverse to bleeding edge, I just want to know whether or not
I'll be struggling on something that just doesn't have enough drivers
written for it to make it usable.

Just in case anyone asks, I'll probably be using Gentoo, but I'm not
glued to that distro.  (I'm very agnostic and just prefer it to work
the best vs. distro-warring..)

Thanks a bunch!

Ed
