Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 08:32:09 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:45807 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492540Ab0FBGbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 08:31:31 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 14EFB274038; Wed,  2 Jun 2010 08:31:11 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 270F8274015;
        Wed,  2 Jun 2010 08:31:08 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 043B284A61;
        Wed,  2 Jun 2010 08:50:21 +0200 (CEST)
Received: by anduin.mandriva.com (Postfix, from userid 500)
        id B9215FF869; Wed,  2 Jun 2010 08:31:17 +0200 (CEST)
Message-Id: <20100601223953.165137063@n5.mandriva.com>
User-Agent: quilt/0.48-1
Date:   Wed, 02 Jun 2010 00:39:53 +0200
From:   apatard@mandriva.com
To:     linux-mips@linux-mips.org
Cc:     aba@not.so.argh.org
Subject: [patch 0/1] loongson: enable rtc on rtc-cmos compatibles systems.
X-archive-position: 26984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1041


Hi,

Now that the rtc-cmos patch has been merged, one can use the rtc-cmos driver
on loongson systems with mc146818 compatible rtc.


Arnaud
