Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 08:09:28 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:48130 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491923Ab0ADHJY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2010 08:09:24 +0100
Received: by ewy23 with SMTP id 23so694648ewy.24
        for <multiple recipients>; Sun, 03 Jan 2010 23:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=fEwdowCE3CieEarvyK13/HtrJWDdIdjGIUqXnTnTdok=;
        b=xM1wbqdjmSoucRP3qqGbX8cCdP272/tOtoEgHZX+QPCRFdKTIzqWjFh9OG/3TUVsJE
         anKipdolPcKQ9kFnPeBDgXE35QQ7AoWN2FOWedrR1lHnF+Cdc0kE6lPFBqztCPm2uUgq
         VSBeNcx75axD+Hd80qfs66s5t3irCyALfJnY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=R25DI1uhljo2jYlXHz5Obxkg0AVSxjmnX1Az0PaH7QOwvUZzOl8zvR3OL6vPJWw0r2
         s25KvhIm1mMbYc5lHEFGk0NTpekRVWqpMNklTqpFg9qF8jknL//Q2YG6eyc0MlVhJFo4
         Fz4d09qwd4kq1ywP9S6R5NKRTE0of7u85DjEQ=
Received: by 10.213.41.209 with SMTP id p17mr4896159ebe.9.1262588958323;
        Sun, 03 Jan 2010 23:09:18 -0800 (PST)
Received: from lenovo.localnet (92.59.76-86.rev.gaoland.net [86.76.59.92])
        by mx.google.com with ESMTPS id 7sm36494403eyg.41.2010.01.03.23.09.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 23:09:16 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 4/4] MTD: include ar7part in the list of partitions parsers
Date:   Mon, 4 Jan 2010 08:09:12 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.32-trunk-686; KDE/4.3.2; i686; ; )
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        ralf@linux-mips.org
References: <201001032117.37459.florian@openwrt.org> <1262552177.3181.5891.camel@macbook.infradead.org>
In-Reply-To: <1262552177.3181.5891.camel@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201001040809.14480.florian@openwrt.org>
X-archive-position: 25497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2222

Hi David,

Le dimanche 3 janvier 2010 21:56:17, David Woodhouse a écrit :
> On Sun, 2010-01-03 at 21:17 +0100, Florian Fainelli wrote:
> > This patch modifies the physmap-flash driver to include
> > the ar7part partition parser in the list of parsers to
> > use when a physmap-flash driver is registered. This is
> > required for AR7 to create partitions correctly.
> 
> Hrm, perhaps we'd do better to allow the probe types to be specified in
> the platform physmap_flash_data?

I guess so, will cook a patch which does that. Thanks!
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
