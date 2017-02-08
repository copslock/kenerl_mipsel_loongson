Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 05:53:41 +0100 (CET)
Received: from mail.linux-iscsi.org ([67.23.28.174]:46214 "EHLO
        linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990552AbdBHExdsXhkl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 05:53:33 +0100
Received: from [192.168.1.66] (75-37-194-224.lightspeed.lsatca.sbcglobal.net [75.37.194.224])
        (using SSLv3 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nab)
        by linux-iscsi.org (Postfix) with ESMTPSA id A4C2140B05;
        Wed,  8 Feb 2017 04:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=linux-iscsi.org;
        s=default.private; t=1486529634; bh=DLH8IJQuKKfR1JnQSR4phlbWvFbNJTm
        LDDCq5/OuXaM=; h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Mime-Version:Content-Transfer-Encoding;
        b=SF3zO8UgMpYNAMwWBLsy/a/iLvtGo/EtQCVwx/N+G4Vt6rwMNteuOwXlpt/45sKyz
        QYSTEs/9TrVx8YriIyATY6dLBQVFDnO1fRr5b7CTUmBQazimvj89N5N8CSxbzgaMCSW
        o6Y7egk3VbFb729Z1PEhyqPEQj3PKastS0EE3oY=
Message-ID: <1486529606.13263.29.camel@haakon3.risingtidesystems.com>
Subject: Re: [PATCH net-next v2 08/12] iscsi: fix build errors when
 linux/phy*.h is removed from net/dsa.h
From:   "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        target-devel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jiri Slaby <jirislaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <woojung.huh@microchip.com>
Date:   Tue, 07 Feb 2017 20:53:26 -0800
In-Reply-To: <20170207230305.18222-9-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
         <20170207230305.18222-9-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <nab@linux-iscsi.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nab@linux-iscsi.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Florian,

On Tue, 2017-02-07 at 15:03 -0800, Florian Fainelli wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> drivers/target/iscsi/iscsi_target_login.c:1135:7: error: implicit declaration of function 'try_module_get' [-Werror=implicit-function-declaration]
> 
> Add linux/module.h to iscsi_target_login.c.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
> ---

Acked-by: Nicholas Bellinger <nab@linux-iscsi.org>
