Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 20:03:38 +0200 (CEST)
Received: from pqueuea.post.tele.dk ([193.162.153.9]:34416 "EHLO
        pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492190Ab0EaSDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 20:03:35 +0200
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
        by pqueuea.post.tele.dk (Postfix) with ESMTP id 0C6D7DBC0B;
        Mon, 31 May 2010 20:03:34 +0200 (CEST)
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id 4172AF84016;
        Mon, 31 May 2010 20:03:21 +0200 (CEST)
Date:   Mon, 31 May 2010 20:03:21 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] mips: fix build with O=...
Message-ID: <20100531180321.GA27518@merkur.ravnborg.org>
References: <20100530141939.GA22153@merkur.ravnborg.org> <AANLkTilwqYZc9-vtHsdBg1JwIOiYEPBtuRG-Rqg6nxNC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTilwqYZc9-vtHsdBg1JwIOiYEPBtuRG-Rqg6nxNC@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

