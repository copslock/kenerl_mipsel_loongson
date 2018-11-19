Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 21:32:15 +0100 (CET)
Received: from rere.qmqm.pl ([91.227.64.183]:10842 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992643AbeKSUaw4CkSg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Nov 2018 21:30:52 +0100
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 42zL6Z3LyMz9F;
        Mon, 19 Nov 2018 21:29:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1542659385; bh=5Z1JxtP6t2MpmKGXF4akUMNKBd1blEAW0J6fQjaV5EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxjYNFSccw0zzZInPSoLJET4HYympSS2jElCLv6epc0NGHrvfbhnY9K0+GrvaAskc
         uUvO4dIk3xEpBb6V7Q67UoPw1ScREh1oJcY+QNpTnOoUdnVQlIV3br7/VS+zt/Q8sH
         2rV4Q6ZHO/lfmv8EczBRrXZHarKER7cdAp90mpqsxu3xHZqAsutSDDAHF5+mntAZaS
         +OyE17c2rTFcN3M7ofG9ELkxhlmN8ywKZ93K/qwbjLU/j4b9r8Jpx98oecBW7mwfpu
         D68sjn6gGxLJN6Pi3NXpylcfDZBaWQ5On2I9mbmHIIBbQZUUHFQvG3enDEvckiTlEF
         Y/gLd+eWq1+uQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Mon, 19 Nov 2018 21:30:46 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling
 from VLAN_TCI
Message-ID: <20181119203046.GA7067@qmqm.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
 <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mirq-linux@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mirq-linux@rere.qmqm.pl
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

On Mon, Nov 19, 2018 at 12:26:46PM +0100, Daniel Borkmann wrote:
> On 11/10/2018 07:58 PM, Micha³ Miros³aw wrote:
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> 
> Why you have empty commit messages for non-trivial changes like this in
> 4 out of 6 of your patches ...
> 
> How was it tested on the JITs you were changing? Did you test on both,
> big and little endian machines?

I have only x86 boxes currently so didn't try to test others. I hope
upstreaming the series through net-next will allow us to find any
fallouts, if any. The changes are very simple, though: they move
code around (the "splitting" part) and eventually change a vlan_present
flag's position in a skbuff structure. Dependency on CPU endianness is
removed by using byte loads for the flag.

Best Regards,
Micha³ Miros³aw
