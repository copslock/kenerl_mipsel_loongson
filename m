Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2010 06:51:00 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.150]:9968 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491991Ab0AYFu5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2010 06:50:57 +0100
Received: by ey-out-1920.google.com with SMTP id 26so690284eyw.52
        for <linux-mips@linux-mips.org>; Sun, 24 Jan 2010 21:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=TBza8mz/YhuXTydQKnmA11jzSn6clWqW4etj+BZjLrs=;
        b=cnQUBspD77Q4J8jZRrQLGbBDmJCqkUnOaXfggh5q41LXmvtFxN/6FD0ynZ4mmxBt4T
         T9mYcl59cxlceERe8byPB+NYHQKYK/PQmQgxs+JQa+8DOPw2L/Zw622YrVLQ10YSOr6i
         skQUp/ePMzBjni0PSuLFi1iSAUHVv0TH299Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aQVLP2vmIqxcYeaNwUC5uN16fzdNzBA1bHS5NWe9PxFlOyTUI308nnkQUNNIsrg6Qx
         o7iabEuxsRnO2ZHpOHEKK8X6Sd/EN/Ry1x9xpkMUw8I45QSHHuQPlXoXo1lWOFXQVAx4
         cg3XSutgb0kYkK5OT7OtMCSw+nYLl+effn88w=
MIME-Version: 1.0
Received: by 10.216.86.3 with SMTP id v3mr2382867wee.165.1264398655113; Sun, 
        24 Jan 2010 21:50:55 -0800 (PST)
Date:   Mon, 25 Jan 2010 02:50:55 -0300
Message-ID: <6675c11001242150v44795f7axd4c9c09a5ed8a8ab@mail.gmail.com>
Subject: binary concatenation
From:   hernan lopez pardo <hernanlopezpardo@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 25647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hernanlopezpardo@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15832

Hello, simple question

$t1 = 101
$t2 = 11

How I do for concatenate $t1, $t2 for obtain $t3 = 10111 ?.

Thanks.
