Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 02:52:42 +0100 (CET)
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38442 "EHLO
        out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494401AbZLDBwi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 02:52:38 +0100
Received: from compute2.internal (compute2.internal [10.202.2.42])
        by gateway1.messagingengine.com (Postfix) with ESMTP id DCA64C549B;
        Thu,  3 Dec 2009 20:52:30 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute2.internal (MEProxy); Thu, 03 Dec 2009 20:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=ju6bCbA9v+KRDc8UnRIBvBhpNPI=; b=slUBbppV5/AVxOLnjCsoLmyx6ZM1bD6/N8c2/q9n7QBB+6+8UEST/cZM86W5Cs66Wf3Hw8d/XwxJKHuiaVmRKYL71ntP1F+ZsVFsFxZ2OznzJu98k3Zjj3qDHyF4Sax1tHEWKh6bRLo9TgstVgLL2PphbJTQpVRHm2Bz8yj03+Q=
Received: by web8.messagingengine.com (Postfix, from userid 99)
        id C15581F755; Thu,  3 Dec 2009 20:52:30 -0500 (EST)
Message-Id: <1259891550.19943.1348372917@webmail.messagingengine.com>
X-Sasl-Enc: Ats8HmdO8YkLEd2IIl9WWRXGcLgT2cIc4ICBg8qDAIKp 1259891550
From:   myuboot@fastmail.fm
To:     linux-kernel@vger.kernel.org,
        "linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com><4AD906D8.3020404@caviumnetworks.com><1255996564.10560.1340920621@webmail.messagingengine.com><200910200817.24018.florian@openwrt.org><1256676013.24305.1342273367@webmail.messagingengine.com>
 <20091028103551.0b4052d8@pixies.home.jungo.com>
Subject: PIR OFFSET for AR7
In-Reply-To: <20091028103551.0b4052d8@pixies.home.jungo.com>
Date:   Thu, 03 Dec 2009 19:52:30 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

Hi, What is the use of PIR register for AR7 board in file
arch/mips/ar7/irq.c? If I understand it right, PIR is used to define the
polarity of the interrupts. It seems to me that it needs to initialized?

Best regards, Andrew
