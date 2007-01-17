Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 16:45:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:59327 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20053196AbXAQQpM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jan 2007 16:45:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0HGkBrv001391;
	Wed, 17 Jan 2007 16:46:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0HGkARn001390;
	Wed, 17 Jan 2007 16:46:10 GMT
Date:	Wed, 17 Jan 2007 16:46:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@int-evry.fr>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for Cobalt Server front LED
Message-ID: <20070117164610.GA1200@linux-mips.org>
References: <200701151936.57738.florian.fainelli@int-evry.fr> <20070116074205.0428449d.yoichi_yuasa@tripeaks.co.jp> <200701160033.10947.florian.fainelli@int-evry.fr> <200701160056.00748.florian.fainelli@int-evry.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701160056.00748.florian.fainelli@int-evry.fr>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 16, 2007 at 12:56:00AM +0100, Florian Fainelli wrote:

> Answering back to myself, since I fixed the stuff using the COBALT_LED_PORT, 
> here the corrected patch. Can you queue this patch for a commit if it sounds 
> acceptable to you ?
> 
> Thank you very much in advance.

Signed-off???

> +void cobalt_led_set(struct led_classdev *led_cdev, enum led_brightness 
> brightness)

This function is only used locally so should be static.

  Ralf
