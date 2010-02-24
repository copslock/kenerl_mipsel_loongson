Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 08:45:56 +0100 (CET)
Received: from mail-gx0-f224.google.com ([209.85.217.224]:64265 "EHLO
        mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491782Ab0BXHpx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 08:45:53 +0100
Received: by gxk24 with SMTP id 24so3102766gxk.7
        for <multiple recipients>; Tue, 23 Feb 2010 23:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=UcgzPmJ2msC/YbwTBPqexO7KdJ1gd1C+vx4Rs8pUI9o=;
        b=bU1Cq/AjzqJojnEChf6BbLhtZrT7yynttrNhY9MeA2rseVMg1kYNN6xhQdjRyRFYLj
         VN+2Oznan0SSdy10M+hqjIlRd7ymRWeSqpgD5xcD9JowiyGvrrai2j1J2b9NBtrndOsb
         6+NC61cdFWU+hMbxWjKRs5kPhuBWFfoLWZDTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=YJfJi6cWZrzKzSkuZBbHlc7XmllkTDSTi+cTc/JTwr3x1tCxTAgk1bXFDeRCCiz0EC
         D7+mVYC5B05dEIiimT2/0ORMXB+kFJBdfchb0aPyGuqkGCatD49rbsTc4293oNNGl+gh
         8KDxXLXz9YcJxhXIt1/b4Anh4wEyCzPudCzdc=
Received: by 10.100.27.37 with SMTP id a37mr2932886ana.163.1266997546162;
        Tue, 23 Feb 2010 23:45:46 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm5298430gxk.11.2010.02.23.23.45.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:45:45 -0800 (PST)
Date:   Wed, 24 Feb 2010 16:45:35 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     linux-mips <linux-mips@linux-mips.org>
Cc:     yuasa@linux-mips.org
Subject: TITAN ethernet driver  exist only in linux-mips
Message-Id: <20100224164535.944fb156.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi,

The four files exist only in linux-mips.

drivers/net/titan_mdio.h
drivers/net/titan_mdio.c
drivers/net/titan_ge.h
drivers/net/titan_ge.c

What should we do to these?

Yoichi
