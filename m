Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:26:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40158 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493363AbZKCP0k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:26:40 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA3FS7mu001856;
	Tue, 3 Nov 2009 16:28:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA3FS7Cw001854;
	Tue, 3 Nov 2009 16:28:07 +0100
Date:	Tue, 3 Nov 2009 16:28:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [RFC PATCH 1/3] MIPS: Alchemy: extended DB1200 board support.
Message-ID: <20091103152807.GB1742@linux-mips.org>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 02, 2009 at 09:21:43PM +0100, Manuel Lauss wrote:

> Create own directory for DB1200 code and update it with new features.
> 
> - SPI support:
>   - tmp121 temperature sensor
>   - SPI flash on DB1200
> - I2C support
>   - NE1619 sensor
>   - AT24 eeprom
> - I2C/SPI can be selected at boot time via switch S6.8
> - Carddetect IRQs for SD cards.
> - gen_nand based NAND support.
> - hexleds count sleep/wake transitions.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks, queued for 2.6.33.

  Ralf
