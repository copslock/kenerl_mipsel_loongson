Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jan 2008 21:05:08 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.157]:62327 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20021942AbYAMVE7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Jan 2008 21:04:59 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1876994fga.32
        for <linux-mips@linux-mips.org>; Sun, 13 Jan 2008 13:04:59 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=6DhCziLlG6YAb/6azqmycDeVawMKt6q7wFQwa03sEXQ=;
        b=PfXMtHZUyVgN6EE0Fx5YGgCPj/6VDq14b/NFE20HNBv+rHUK74UngKww44T9oipKUpOuhhFP/c8HRcZWiokc1cD/d/e5ZoPnHbAG8tuz+uy/axBQDazoureyvVrFEJgS2aXqNQjulMaOUJR8QtRCc49VequHYpP10A9ObEKHrWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=LRPMOhT3w9IdFQEhZ0D3EsHv1xoDqf9BHTogjcDh4YHBTfb8oRKY+WtH2cZbpNFJIiUuXCEAgBDdJzKo++3HTqv9cCdJUVO5d9NYpgUTkIkW6BJycWa0YqVHenwW1CzYPRrYMf/Vb3eq+E0tNIQ3io8IdXHvDaUFio+zlZsKUX0=
Received: by 10.86.89.4 with SMTP id m4mr5470760fgb.45.1200258298875;
        Sun, 13 Jan 2008 13:04:58 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.30.108])
        by mx.google.com with ESMTPS id v23sm8007452fkd.1.2008.01.13.13.04.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jan 2008 13:04:57 -0800 (PST)
Message-ID: <478A7CF7.60804@gmail.com>
Date:	Mon, 14 Jan 2008 00:04:55 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [RFC] cleanup of board-specific code?
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

I stumbled upon a bug in the board initialization code for Malta. While
researching this bug, I noticed that the files in arch/mips/mips-boards
contain multiple coding style violations, sloppily written constructs and
many other things, which seem to be in obvious need of cleaning up.

I think I can prepare and post a series of patches with a massive code
cleanup for the places mentioned above. The question is: would the MIPS
maintainers be interested in applying such changes? If yes, I could do
that in nearest future; if not, I will post a patch, which merely fixes
the Malta board initialization bug.

Thanks,

Dmitri
