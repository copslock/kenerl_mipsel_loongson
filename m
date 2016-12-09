Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 12:27:09 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992111AbcLIL1C320U4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2016 12:27:02 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05A373D979;
        Fri,  9 Dec 2016 11:26:55 +0000 (UTC)
Received: from griffin (ovpn-204-93.brq.redhat.com [10.40.204.93])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uB9BQplp031879
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Dec 2016 06:26:52 -0500
Date:   Fri, 9 Dec 2016 12:26:50 +0100
From:   Jiri Benc <jbenc@redhat.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Netdev <netdev@vger.kernel.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
Message-ID: <20161209122650.36a1a8e8@griffin>
In-Reply-To: <87vauvhwdu.fsf@alice.fifthhorseman.net>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
        <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
        <87vauvhwdu.fsf@alice.fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 09 Dec 2016 11:26:55 +0000 (UTC)
Return-Path: <jbenc@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbenc@redhat.com
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

On Wed, 07 Dec 2016 23:34:21 -0500, Daniel Kahn Gillmor wrote:
> fwiw, i'm not convinced that "most protocols of the IETF follow this
> mantra".  we've had multiple discussions in different protocol groups
> about shaving or bloating by a few bytes here or there in different
> protocols, and i don't think anyone has brought up memory alignment as
> an argument in any of the discussions i've followed.

Which is sad. One would expect that this would be well understood for
decades already.

 Jiri
