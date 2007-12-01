Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Dec 2007 21:13:38 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:46018 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025949AbXLAVNa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Dec 2007 21:13:30 +0000
Received: by nf-out-0910.google.com with SMTP id c10so2240681nfd
        for <linux-mips@linux-mips.org>; Sat, 01 Dec 2007 13:13:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=gM3lwe+Nj1yr/1VlODck0P6qaeKvLRMgCeqtuEi5tBc=;
        b=fsdiol9sKTTx5RNXDGhh3vfEDc6Tev9mfq9WCIUUwdAAMMPMcoMYZ58ApkTWPribRHJpa3eytgS7xvd/3uu+02F360+CuQo8sSBbfRi9rsKALo+LvhFqETi3cOmL5v56nESnA93Gm7QbiHeKnw0ULZlWpiAxY+8BHUEwldbMgxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=OfUmBMrXh5dDVlDpVWAd7p3WcN9Nljrg2y01yKqYhTJvWtOy4qN0/GGyKeH1uNEKuiSfngsMyNrISy7tH3w+9+UBCr2RzAVAdRlukyo3GZWzDtivaytbM8jXRAmHphCBkGFrsHIs4KQ4irDZU+VJGqL0qWx2QOl9jQTZbk4AND8=
Received: by 10.78.131.8 with SMTP id e8mr4514560hud.1196543609381;
        Sat, 01 Dec 2007 13:13:29 -0800 (PST)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id y2sm20915525mug.2007.12.01.13.13.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2007 13:13:28 -0800 (PST)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-arch@vger.kernel.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: [RFC] Yet another __init annotation: __initbss
Date:	Sat,  1 Dec 2007 22:13:04 +0100
Message-Id: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.5
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Currently, there's no way to make a data part of both the init section
and the bss section. Therefore uninitialized init data consume useless
space in the vmlinux image.

Most of these data can be listed by:

     $ git grep -E "__initdata([^=]*| ?= ?0);" -- *.c

This short patchset is an attempt to make these init data part of the
bss section (done by patch #1) and therefore decreases the size of the
vmlinux image.

For now, only MIPS architecture handles this new section, this is done
by patch #2. It's only a start and should be enough for discussion.

Please consider,

                Franck
