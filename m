Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 15:12:24 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:44625 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029687AbXIZOMO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 15:12:14 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1303727uge
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 07:12:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=qco6VHcI5rl2AeLx6dcSSRcUKdxsQ9qOWl9soAZzo/0=;
        b=sbkyT+mGIWScFCwQGpjB6+gFz9f++Yv3caeFu5TmhF9iLRNKPDdk8qS1MSEFx0Fq16JXAUKr8YYKfGnFj+IVH2HIlDguZLclhgcFk/lfrXg7JMULC8lzTVKmSJQTBNNlcsKmHLrP2y4+XnROOskRk9ZDt+sRa0Ws33WNTG0DVXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Fn0E7sRQqzaefuOk8SuAsyck+NN8FOQeU0hoqOzmlsttndBlOR4Q5I4OLWk2XqjdBSF2KX74bakWljPF3dbS5NxD4a1Sny0qDh0BTyEEf2p0TqOb2j2Urw3+6BptbgKyS3NRBDyUcJIderDbxI1kNPDoo94lhbYa8rNRPmXoK2s=
Received: by 10.67.21.11 with SMTP id y11mr2231289ugi.1190815929755;
        Wed, 26 Sep 2007 07:12:09 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e32sm1728946fke.2007.09.26.07.12.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Sep 2007 07:12:09 -0700 (PDT)
Message-ID: <46FA6846.2080704@gmail.com>
Date:	Wed, 26 Sep 2007 16:10:14 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	nigel@mips.com, linux-mips <linux-mips@linux-mips.org>
Subject: Useless stack randomization patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

We started stack inside page randomization through commit
941091024ef0f2f7e09eb81201d293ac18833cc8 but it currently does nothing
usefull because ELF_PLATFORM is not defined on MIPS (see
fs/binfm_elf.c, create_elf_tables() for details).

I tried several times to get information on lkml about that dependency
but unfortunately I got no answer.

I'm not sure how ELF_PLATFORM is used by ld.so and I don't think it's
a good idea to define it just for enabling stack randomization.

What do you think ?

thanks
		Franck
