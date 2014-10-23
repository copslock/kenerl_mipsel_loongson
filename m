Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 02:29:14 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:14187 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012186AbaJWA3MdQolV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 02:29:12 +0200
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDV008ZXG0G1B50@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Thu, 23 Oct 2014 09:29:04 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.44])
        by epcpsbgr4.samsung.com (EPCPMTA) with SMTP id B8.DF.18167.0DB48445; Thu,
 23 Oct 2014 09:29:04 +0900 (KST)
X-AuditID: cbfee690-f79ab6d0000046f7-31-54484bd0c215
Received: from epmailer02 ( [203.254.219.142])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id C6.5B.22636.0DB48445; Thu,
 23 Oct 2014 09:29:04 +0900 (KST)
Date:   Thu, 23 Oct 2014 00:29:04 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: Re: Re: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20141023002307469@eunb.song
Msgkey: 20141023002307469@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-MLAttribute: 
X-RootMTR: 20141023002307469@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
X-ConfirmMail: N,general
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <863134949.204101414024143724.JavaMail.weblogic@epmlwas06c>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsVy+t8zHd0L3h4hBrsumFpMmDqJ3YHR4+jK
        tUwBjFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66FkoKGfnFJbZK0UYGxnpGpiZ6RibmepYG
        sVZGpkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIKfoFSfmFpfmpesl
        5+cqKZQl5pQCjVDST5jKmLHm53Pmgn8cFbu/nGJuYLzD0cXIySEkoCLR8v87I4gtIWAisfLQ
        DihbTOLCvfVsEDXLGCVOnWSGqZn7fzZ7FyMXUHwOo8TbyzPAEiwCqhL3NsxkB7HZBLQlfhy4
        ChYXFvCR2DP9I9hQEQEticYXL5lBmpkFVjNKvNncxwqxQV5i8unLYM28AoISJ2c+Yeli5ADa
        piRx+6UDRFhZYt/GBhaIIyQkZk2/wAph80rMaH8KFZeTmPZ1DdSh0hLnZ22Ae2bx98dQcX6J
        Y7d3MEHYAhJTzxyEqlGXaJr1ng3C5pNYs/At1ExBidPXuplhdt3fMpcJ5oatLU/AbmAWUJSY
        0v2QHcLWkvjyYx8bqldAbHeJda+fsYH8LiEwl0Pi9exvzBMYlWYhqZuFZNYsJLOQ1SxgZFnF
        KJpakFxQnJReZIIc3ZsYIclwwg7GewesDzEKcDAq8fA6sLmHCLEmlhVX5h5iTAbG00RmKdHk
        fGDKzSuJNzQ2M7IwNTE1NjK3NMMQNjG1sDAxwiGsJM77WupnsJBAemJJanZqakFqUXxRaU5q
        8SFGJg5OqQbGzKU7mmu9q5dI5l9rTJqdb+i36USmQ+H8sAvq83Ynnir80h8v+ejwb7n4W2Ls
        plaPt3OG/zITvPL0qLWr2NHvD/OVYx7Wn776a+2Jmxczt5jyL2Z7K7zg14pTp89V/dydeWad
        xJyW5Rctzh021bnqu2eKrfRVCRvGqYHNU77Pkp53Z6Nc+Zmz/kosxRmJhlrMRcWJAFeAjj+v        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsVy+t/tPt0L3h4hBnObjC0mTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIw1P58zF/zjqNj95RRzA+Mdji5GTg4hARWJlv/fGUFsCQETibn/Z7ND2GISF+6tZ+ti5AKq
        mcMo8fbyDGaQBIuAqsS9DTPBitgEtCV+HLgKFhcW8JHYM/0j2CARAS2JxhcvmUGamQVWM0q8
        2dzHCrFNXmLy6ctgzbwCghInZz5h6WLkANqmJHH7pQNEWFli38YGFogjJCRmTb/ACmHzSsxo
        fwoVl5OY9nUNM4QtLXF+1gZGmKMXf38MFeeXOHZ7BxOELSAx9cxBqBp1iaZZ79kgbD6JNQvf
        Qs0UlDh9rZsZZtf9LXOZYG7Y2vIE7AZmAUWJKd0P2SFsLYkvP/axoXoFxHaXWPf6GdsERtlZ
        SFKzkLTPQtKOrGYBI8sqRtHUguSC4qT0CiO94sTc4tK8dL3k/NxNjOB09GzRDsZ/560PMQpw
        MCrx8M7gcA8RYk0sK67MPcQowcGsJMJba+0RIsSbklhZlVqUH19UmpNafIjRFBhrE5mlRJPz
        gakyryTe0NjA2NDQ0tzA1NDIQkmcV/5WUpCQQHpiSWp2ampBahFMHxMHp1QDY7y19Z1FSxUb
        ubwinmgLJIccVf52t1bp9aLob89f6aWdkTFMWHnpVG2gRdTNLRPi3qt9uLa/55X67/KMiz1S
        z7/NPnXWZ8oCoYLe2eI79jzViva/eX9yo0dQ/bb1j37b7Xb88s/64rM/FdOV93BPjzuTJZZ4
        bP49o5J5Qmvvs354f06X22NrwR4lluKMREMt5qLiRABqGTQWXQMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eunb.song@samsung.com
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

DQoNCj4+IFRoaXMgcGF0Y2ggYWRkcyBhcmNoX3RyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UoKSBm
b3IgbWlwcyBhcmNoaXRlY3R1cmUuDQoNCj4gRG9uJ3QgZm9yZ2V0IHlvdXIgU2lnbmVkLW9mZi1i
eQ0KDQpJJ20gc29ycnkgZm90IHRoaXMuIA0KDQo+PiArc3RhdGljIHZvaWQgYXJjaF9kdW1wX3N0
YWNrKHZvaWQgKmluZm8pDQo+PiArew0KPj4gKyBzdHJ1Y3QgcHRfcmVncyAqcmVnczsgIA0KPj4g
KyANCj4+ICsgcmVncyA9IGdldF9pcnFfcmVncygpOw0KPj4gKw0KPj4gKyBpZihyZWdzKQ0KPj4g
KyBzaG93X3JlZ3MocmVncyk7DQo+PiArDQo+PiArIGR1bXBfc3RhY2soKTsNCj4+ICt9DQo+PiAr
DQo+PiArdm9pZCBhcmNoX3RyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UoYm9vbCBpbmNsdWRlX3Nl
bGYpDQo+PiArew0KPj4gKyBzbXBfY2FsbF9mdW5jdGlvbihhcmNoX2R1bXBfc3RhY2ssIE5VTEws
IDEpOw0KDQo+IHNob3VsZCB0aGlzIGNhbGwgYXJjaF9kdW1wX3N0YWNrIGRpcmVjdGx5IHRvbyBp
ZiBpbmNsdWRlX3NlbGY/DQpDdXJyZW50bHksIGluIGNhc2Ugb2YgbWlwcyB0aGVyZSBpcyBubyBj
YXNlIGluY2x1ZGVfc2VsZiBpcyB0cnVlLCBzbyB0aGlzIGlzIG5vdCBhIHByb2JsZW0uIA0KYXJj
aF90cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlIGNhbiBvbmx5IGJlIGNhbGxlZCBmcm9tIHRyaWdn
ZXJfYWxsYnV0c2VsZl9jcHVfYmFja3RyYWNlKCkgaW4ga2VybmVsL3dhdGNoZG9nLmMuDQpCdXQg
YXMgeW91IHNhaWQsIGlmIHRoZSBjYXNlIHdpbGwgYmUgYWRkZWQsIHdlIHNob3VsZCBjb25zaWRl
ciB0aGF0Lg0KDQpUaGFua3MuDQoNCj4gQ2hlZXJzDQo+IEphbWVz
