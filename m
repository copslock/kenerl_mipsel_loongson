Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 07:58:14 +0100 (CET)
Received: from mail-yw0-f186.google.com ([209.85.211.186]:49713 "EHLO
        mail-yw0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491803Ab0CJG6J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Mar 2010 07:58:09 +0100
Received: by ywh16 with SMTP id 16so4554754ywh.0
        for <multiple recipients>; Tue, 09 Mar 2010 22:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=pJYmVtfvtWBiMBqPM7ZKJBJ+05zUgjG4Mm6xy8XMIcs=;
        b=VuCRCHrOGiZ8mLAmzkGjdLS1dxHg53gEDUzqH8RP85xqdanlsjvPCIUsMSenCmdU/C
         X/7PVhV5Y6B512TtGBDdKYZ39UO/zIcowVQekRUy7iM1cyxMjA0Ubkk8Hk4LMxcdls77
         0x6V6oKh2mcugGj/1tFjbMPKROTLvWFMJ3lSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ZeFAWJ7Ns0TLYqrjlOyI1GuzV/sjX/iuZzufhSryh+jOk6L9qZhKZxxLpEwyhPIpOh
         /u3ubrfZ/JgJKJEZC5ynb9Wnuf978l20ZWOoXDRPO6BBhEd0FzuwRx5VZfgXjvoYhPF0
         tvoyd4XrMnf6UCEttXAmmIZy3VeSKu4GkAMrs=
Received: by 10.101.21.15 with SMTP id y15mr770039ani.190.1268204281712;
        Tue, 09 Mar 2010 22:58:01 -0800 (PST)
Received: from stratos.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm4974598gxk.2.2010.03.09.22.57.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 22:58:01 -0800 (PST)
Date:   Wed, 10 Mar 2010 15:57:56 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     yuasa@linux-mips.org, linux-pcmcia@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] pcmcia/vrc4171: use local spinlock for device local lock.
Message-Id: <20100310155756.496e2bbf.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.0.0 (GTK+ 2.16.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

struct pcmcia_socket lock had been used before.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/pcmcia/vrc4171_card.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/vrc4171_card.c b/drivers/pcmcia/vrc4171_card.c
index c9fcbdc..aaccdb9 100644
--- a/drivers/pcmcia/vrc4171_card.c
+++ b/drivers/pcmcia/vrc4171_card.c
@@ -105,6 +105,7 @@ typedef struct vrc4171_socket {
 	char name[24];
 	int csc_irq;
 	int io_irq;
+	spinlock_t lock;
 } vrc4171_socket_t;
 
 static vrc4171_socket_t vrc4171_sockets[CARD_MAX_SLOTS];
@@ -327,7 +328,7 @@ static int pccard_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
 	slot = sock->sock;
 	socket = &vrc4171_sockets[slot];
 
-	spin_lock_irq(&sock->lock);
+	spin_lock_irq(&socket->lock);
 
 	voltage = set_Vcc_value(state->Vcc);
 	exca_write_byte(slot, CARD_VOLTAGE_SELECT, voltage);
@@ -370,7 +371,7 @@ static int pccard_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
 		cscint |= I365_CSC_DETECT;
         exca_write_byte(slot, I365_CSCINT, cscint);
 
-	spin_unlock_irq(&sock->lock);
+	spin_unlock_irq(&socket->lock);
 
 	return 0;
 }
-- 
1.7.0.2
