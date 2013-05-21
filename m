Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 12:25:48 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:37743 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3EUKZmwV2LT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 May 2013 12:25:42 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4LAPbHf021917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 21 May 2013 06:25:37 -0400
Received: from localhost.localdomain (vpn1-4-204.gru2.redhat.com [10.97.4.204])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r4LAPS2T009343
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 21 May 2013 06:25:32 -0400
Date:   Tue, 21 May 2013 07:25:21 -0300
From:   Mauro Carvalho Chehab <mchehab@redhat.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        spi-devel-general@lists.sourceforge.net,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig
 CAVIUM_OCTEON_REFERENCE_BOARD to CAVIUM_OCTEON_SOC
Message-ID: <20130521072521.0a296a67@redhat.com>
In-Reply-To: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <mchehab@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchehab@redhat.com
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

Em Mon, 20 May 2013 15:19:38 -0700
David Daney <ddaney.cavm@gmail.com> escreveu:

> From: David Daney <david.daney@cavium.com>
> 
> CAVIUM_OCTEON_SOC most place we used to use CPU_CAVIUM_OCTEON.  This
> allows us to CPU_CAVIUM_OCTEON in places where we have no OCTEON SOC.
> 
> Remove CAVIUM_OCTEON_SIMULATOR as it doesn't really do anything, we can
> get the same configuration with CAVIUM_OCTEON_SOC.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-edac@vger.kernel.org

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

> Cc: linux-i2c@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: spi-devel-general@lists.sourceforge.net
> Cc: devel@driverdev.osuosl.org
> Cc: linux-usb@vger.kernel.org

Regards,
Mauro
