Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 07:19:22 +0200 (CEST)
Received: from qw-out-1920.google.com ([74.125.92.146]:27087 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492742AbZJPFTP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 07:19:15 +0200
Received: by qw-out-1920.google.com with SMTP id 5so478825qwc.54
        for <multiple recipients>; Thu, 15 Oct 2009 22:19:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ki0aw3mXT+5IghXuEZsNlh06USD201RpcZbEdeiGTYg=;
        b=X4HUa9d9WOqZLgfBQmjYlp05OR2i4ImLyHLGaf0dz1AytvX2lGu4ks1Z/Yb54omE7l
         Y2uI6FBGyqgvTBW70epf4IqqWxgnlBXgYwAwI0IFo+WtX84HUHZhxpZ/JGcqjyAyYjVb
         4drYLbJ99nMuiSCUTPQuWmL9mfPXJi7NLJ7U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=gFOUIi3TzjycyAfh5degw4Cey3xhQA6UEMAUizKdw4IS7YQCkv7nf+lUvVadvIa2MV
         E2AOjujdvFX4YRGeqhJ8OwDVniRJsoCNuJi/mZAZCuk88T47y+cxDKNJYshNN/pzfG0K
         WMQk4HihZ7T5B5C/vcKLbLWveiiEjMVQ0Zn3s=
Received: by 10.224.60.28 with SMTP id n28mr765615qah.101.1255670352354;
        Thu, 15 Oct 2009 22:19:12 -0700 (PDT)
Received: from barrios-desktop (c193254.sait.samsung.co.kr [202.20.193.254])
        by mx.google.com with ESMTPS id 7sm1844053qwb.2.2009.10.15.22.19.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 22:19:11 -0700 (PDT)
Date:	Fri, 16 Oct 2009 14:17:19 +0900
From:	Minchan Kim <minchan.kim@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	lkml <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Chungki woo <chungki.woo@gmail.com>
Subject: BUG? linux-mips flush_dcache_page
Message-Id: <20091016141719.de606482.minchan.kim@barrios-desktop>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <minchan.kim@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minchan.kim@gmail.com
Precedence: bulk
X-list: linux-mips

			
Hi, Ralf. 

I suffered form data consistency problem. 

Many code of kernel fs usually allocate high page and flush.
But flush_dcache_page of mips checks PageHighMem to avoid flush
so that data consistency is broken, I think. 

I found it's by you and Atsushi-san on 585fa724. 
Why do we need the check?
Could you elaborte please? 

-- 
Kind regards,
Minchan Kim
