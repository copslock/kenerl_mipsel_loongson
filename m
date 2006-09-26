Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 16:39:44 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:56707 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037632AbWIZPjm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 16:39:42 +0100
Received: by nf-out-0910.google.com with SMTP id l23so230981nfc
        for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 08:39:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LDlERwELwp9QUv6a6tKskPD3JLokFBatLgDHDfNmHxIictYcXQ6IyyxdO480ldskJybHuHmzBPnnqGJcRgq6bogw86kk9ZX189QbHLOLLJJTfpl4BknSH595dSOnCbGdqbmbk/xhwWJdtOS1rJgghYLErEROtswsZyg20YA3E/Q=
Received: by 10.49.29.3 with SMTP id g3mr1191396nfj;
        Tue, 26 Sep 2006 08:39:41 -0700 (PDT)
Received: by 10.48.163.3 with HTTP; Tue, 26 Sep 2006 08:39:41 -0700 (PDT)
Message-ID: <2e134a330609260839l5ab33123p4e712a8fe4e0b60b@mail.gmail.com>
Date:	Tue, 26 Sep 2006 11:39:41 -0400
From:	"s c" <steve.carren@gmail.com>
To:	linux-mips@linux-mips.org
Subject: How is the au1000_gpio char driver used?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <steve.carren@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steve.carren@gmail.com
Precedence: bulk
X-list: linux-mips

Hello All,

I would like to use the au1000_gpio char driver to blink some status
lights. Specifically, I would like to control the hex leds on the
dbau1500 development board. Preferably via shell script.

Any help would be appreciated.

Thanks
