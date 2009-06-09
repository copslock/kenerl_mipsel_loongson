Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2009 13:04:18 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:38328 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021471AbZFIMEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jun 2009 13:04:10 +0100
Received: by ewy19 with SMTP id 19so4675847ewy.0
        for <multiple recipients>; Tue, 09 Jun 2009 05:04:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ftRPqzOkezO1xk6wjfLI1emX8+mkoc09JW0Mbvm5HGg=;
        b=x7r40/Fx0ouXib8wtbedxwU5c/jGff+W3kkqlpnf4Tc5B+xi/aRI0xcPoff5FiPI7y
         gNXFfK1RVSa8UjCAr+iYxCkKSv4W39DlW5dCW/j8plMJUGnMGMPV6w0KbJQ0jm6qF2OF
         Rr7nzZP57VGAVEWqQbaGMe9ossuuRYshicqQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KhRT86xV5r38uRNG0KkQZrjPAQXtPhkHjdl1zSfb6DqALtwXGJt1FNaPLMPnmAJZgm
         lIhuyihZ1q5E54Njnm6hIRpe/oqsMLQT97qoaCR9g7AZ2GxBs28AjPIExBxyLd/BLWbb
         GpqAR3nVQtmWKSGwhtnBuHhjxCDGTUv9ovnN0=
Received: by 10.210.102.12 with SMTP id z12mr5734238ebb.20.1244549043927;
        Tue, 09 Jun 2009 05:04:03 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm66199eyf.38.2009.06.09.05.04.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 05:04:03 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: MIPS: Outline udelay and fix a few issues.
Date:	Tue, 9 Jun 2009 14:03:59 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
References: <S20022929AbZFHPuy/20090608155054Z+9196@ftp.linux-mips.org> <20090609.111248.161838296.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20090609.111248.161838296.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906091404.00870.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Tuesday 09 June 2009 04:12:48 Atsushi Nemoto, vous avez écrit :
> Subject: [PATCH] fix __ndelay build error and add 'ull' suffix for 32-bit
> kernel

Fixes the build error for me. Thanks !
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
