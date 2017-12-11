Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 09:16:02 +0100 (CET)
Received: from mout.web.de ([212.227.17.12]:62088 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990421AbdLKIPzCfCtT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 09:15:55 +0100
Received: from [192.168.1.3] ([92.227.98.61]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1fA-1eFTXu3sMC-008ur1; Mon, 11
 Dec 2017 09:15:47 +0100
Subject: Re: TC: Delete an error message for a failed memory allocation in
 tc_bus_add_devices()
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Cc:     =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <bfb63956-346c-aa17-5b06-fbe19ff0a5e3@users.sourceforge.net>
 <alpine.LFD.2.21.1712102140570.4266@eddie.linux-mips.org>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <60e20b6d-e130-9c18-d5d4-b75349f0d7be@users.sourceforge.net>
Date:   Mon, 11 Dec 2017 09:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1712102140570.4266@eddie.linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:TNrKUKXOTO4auUICD0yK3xeGqhy497xsJuDGKXEeVZpNEApZSno
 yHEMsC07sk/aR78Xr9pwT2+RTGa1Zh/brxvAwVmVeJvQNWM76+1AiromrO1NPOxLW58FYIX
 gPBruzAYhD1Dxf+1JjqHRqWMaykaCcI79ttBT7JynbVzoigHKfweS9e2FltmygT6M5VhNih
 uj6e634YGpAmioZWZNEYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IUSEQqkKLy0=:zSP0CLqLscvdoTk1xZKW3a
 em6mmoIBS99pDgQ2XCR+GzkTKsqoYxj5CrOlqC5Me7UhRHl+TNWJgLqgFPTMxNW9OibRVZaxF
 0sxTEPECv/GpVfJCfoiED9QoZ85JBBJZoIBR8QgvpHt1s2+fQRC8fX1lt92N64929EosTJ4k4
 PXwfO3U5dKNX3S2Zqqe3ph+APmmRTKKjWGGtlJFH3sgLJ7mgms1twWZRiM77Sw/m6lO/7er3f
 MgdBM+gopy566F3/zcy6C7cCGIL0P+Xiu1LkqKQb9n793EaKcEjfSCAQvLEJyl5DMAK+fGU2u
 suP+qxLYOAE0D1oyWtzg7dwDu1ANG0BFkxo85ok059qJyhTTcM3K9jdxonFfb50VTygJ/f9UP
 a9ysFe0nbz9GnNClWISGOMs38tXh3nxYQjLX3ZclOFtT1So9H9yGAV5DapqYWcH040mdB8x6+
 epPTqdLg8MiuOham+TjxxsGrVDrdpb4+e2JBc196eFT+ag4Wf5NTL0hCupRW7UJp9xuiDio8n
 NA99phk/L1vB5YBw1OMYYmnt4wHODN/a2Aig2QJdfo1of9XHbFSNeqsLO+93L3B2eoNr0PGLw
 H1U7/Qb/Mf3gIWzKtm4asCl71RwWAOa61HvRUPRs7qcM914Ft6M3gml3SHyOOQPTtHUU89rq2
 oJ39gIl58DCzpiL1BVudZKBW5IEmfxeZ2b6HB7453lpR0pLjD4d52eWXbpnAx2INk6WOZqTIX
 NEOAPsaZjzN1qNd3oTEb+fjZ81uPod2mfvwrrWJ3JFAgdnGJ1Vcj7XWZ60sKwAByU015NIFhi
 xYcLKWs7mfqczZke3OnvN++KYa0+g2DJXQ4N71WEGev6FUpD30=
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

>> Omit an extra message for a memory allocation failure in this function.
>>
>> This issue was detected by using the Coccinelle software.
> 
>  And the problem here is?

I suggest to reconsider the relevance of another error message.
Would you like to achieve a better explanation for this use case?

* Do you find the wording “WARNING: Possible unnecessary 'out of memory' message”
  from the script “checkpatch.pl” more appropriate?

* Can a default Linux allocation failure report be sufficient?

Regards,
Markus
