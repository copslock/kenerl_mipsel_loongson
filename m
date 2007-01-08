Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 13:59:50 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.187]:64663 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20044904AbXAHN7q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 13:59:46 +0000
Received: by nf-out-0910.google.com with SMTP id l24so8689195nfc
        for <linux-mips@linux-mips.org>; Mon, 08 Jan 2007 05:59:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jTQ/GTIi3WS+sYEECgTHZtC918ZXkIXDeUom7mii9CdFNTJaWTaSM/W51uQ8xVn3zuowm9YB5p0TK8Pt+80rdSI9u5yZuyTuxom1xmS/Fidld9dXIQsW4gSJ49MG0E+JnZrcbnnPZKFd2tS66PhnCEZ2413VCcLHJcYFGNrWtyo=
Received: by 10.82.136.4 with SMTP id j4mr2052697bud.1168264786192;
        Mon, 08 Jan 2007 05:59:46 -0800 (PST)
Received: by 10.82.179.13 with HTTP; Mon, 8 Jan 2007 05:59:46 -0800 (PST)
Message-ID: <50c9a2250701080559m66bb04afqd5c9eb1871b85928@mail.gmail.com>
Date:	Mon, 8 Jan 2007 21:59:46 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: run linux on hardware without kseg2?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

hello all
      our team want to use the mips kesg2 to do other things.and i
found in linux that seems it use kseg2 in vmalloc?
is that possible to remove kseg2 and the linux can also run ?

Best Regards

sky
