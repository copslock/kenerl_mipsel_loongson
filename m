Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 06:49:13 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:57704 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821310Ab3DLEtLgA1cK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Apr 2013 06:49:11 +0200
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0ML4003RKLDN3070@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Fri, 12 Apr 2013 13:49:00 +0900 (KST)
Received: from epcpsbgx1.samsung.com ( [203.254.230.45])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id 3C.2A.20872.C3297615; Fri,
 12 Apr 2013 13:49:00 +0900 (KST)
X-AuditID: cbfee68d-b7f786d000005188-62-5167923c2450
Received: from epextmailer02 ( [203.254.219.152])
        by epcpsbgx1.samsung.com (EPCPMTA) with SMTP id C2.30.14546.C3297615; Fri,
 12 Apr 2013 13:49:00 +0900 (KST)
Date:   Fri, 12 Apr 2013 04:49:00 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH] mips: Fix typo in cavium-octeon
To:     ralf@linux-mips.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130412044003865@eunb.song
Msgkey: 20130412044003865@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130412044003865@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <8832811.197761365742139632.JavaMail.weblogic@epml12>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e+Zrq7NpPRAg4ffDS0mTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujDU3OtkKDvBVzP/RydzA2MPXxcjJISSgItHy/zsjiC0hYCKx
        9eVOdghbTOLCvfVsXYxcQDXLGCU+Nhxghil69+AlE0RiPqPEg9vfWUESLAKqEpOfzAXrZhPQ
        lnj75QFYXFjAQGLyluVMILaIgIzE0k9XwLYxCyRL/H97nAniCnmJyacvg/XyCghKnJz5hAVi
        mZLEs+8nWSDiyhJt++axQcQlJGZNv8AKYfNKzGh/ClUvJzHt6xqoQ6Ulzs/awAjzzeLvj6Hi
        /BLHbu8A2ssB1vvkfjDMmN2bv0CNF5CYeuYgI0SJukTHciWIMJ/EmoVvWWCm7Dq1nBmm9f6W
        uUwQXylKTOl+yA5ha0l8+bGPDd1XvAKOEmu3n2ecwKg8C0lqFpL2WUjakdUsYGRZxSiaWpBc
        UJyUXmSoV5yYW1yal66XnJ+7iRGSGHp3MN4+YH2IMRkYIxOZpUST84GJJa8k3tDYzMjC1MTU
        2Mjc0ow0YSVxXrUW60AhgfTEktTs1NSC1KL4otKc1OJDjEwcnFINjPPvnkn3/Xrqa8PTI9tP
        zewT+bHl5KpHrhvqdux0uh2bVrvTqEdlit9/Z5/pDR8Ljhy4dkNJSLAhr7Hxj9D7G2lzdA/e
        yPR43KLvcDTfddY359tvimULrCZ+eP09PlBPTuKx5rO9676EPstXZV3ys8jtuqnZrN1aTvFF
        pv8DXBm0sw4mB2dZSyuxFGckGmoxFxUnAgAslYDuIgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2DF2bSemBBt9m6VtMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRlrbnSyFRzgq5j/o5O5gbGHr4uRk0NIQEWi5f93RhBbQsBE4t2Dl0wQtpjEhXvr2boYuYBq
        5jNKPLj9nRUkwSKgKjH5yVx2EJtNQFvi7ZcHYHFhAQOJyVuWgzWLCMhILP10BWwos0CyxP+3
        x5kglslLTD59GayXV0BQ4uTMJywQy5Qknn0/yQIRV5Zo2zePDSIuITFr+gVWCJtXYkb7U6h6
        OYlpX9cwQ9jSEudnbWCEOXrx98dQcX6JY7d3AO3lAOt9cj8YZszuzV+gxgtITD1zkBGiRF2i
        Y7kSRJhPYs3CtywwU3adWs4M03p/y1wmiK8UJaZ0P2SHsLUkvvzYx4buK14BR4m1288zTmCU
        m4UkNQtJ+ywk7chqFjCyrGIUTS1ILihOSq8w1CtOzC0uzUvXS87P3cQITlHPFu5g/HLe+hCj
        AAejEg/vC+H0QCHWxLLiytxDjBIczEoivDF70wKFeFMSK6tSi/Lji0pzUosPMSYD428is5Ro
        cj4wfeaVxBsaGxgbGlqaG5gaGlmQJqwkzvu01TpQSCA9sSQ1OzW1ILUIZgsTB6dUA6Ok5bLL
        L2exnW6V4P06XfhBhCjbnwsfGuznL/u6Ytuy7y92T2QN3GCccWFhIut3t+Z9EcfkTxX4SS53
        lVzH0NBgV/Dys+yNvYEz1ncpWU6809PpfHTN1ki9z9VLZdK09LnTFzL6OPmFdXByOc48+zA5
        MLAuIvcaa6fptsvKb/TMdO0vvWDe+VuJpTgj0VCLuag4EQC9OSTolQMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36083
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

DQpJIHRoaW5rICJDVUkyIiBzaG91bGQgYmUgY2hhbmdlZCB0byAiQ0lVMiIsIGJlY2F1c2UgQ0lV
IG1lYW5zIENlbnRyYWwgSW50cnJ1cHQgVW5pdC4NCg0KU2luZ2VkLW9mZi1ieTogRXVuQm9uZyBT
b25nPGV1bmIuc29uZ0BzYW1zdW5nLmNvbT4NCg0KLS0tDQogYXJjaC9taXBzL2Nhdml1bS1vY3Rl
b24vb2N0ZW9uLWlycS5jICAgICAgICAgICB8ICAgIDIgKy0NCiBhcmNoL21pcHMvaW5jbHVkZS9h
c20vbWFjaC1jYXZpdW0tb2N0ZW9uL2lycS5oIHwgICAgMiArLQ0KIDIgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBz
L2Nhdml1bS1vY3Rlb24vb2N0ZW9uLWlycS5jIGIvYXJjaC9taXBzL2Nhdml1bS1vY3Rlb24vb2N0
ZW9uLWlycS5jDQppbmRleCAxNTZhYTYxLi41MmFhOWNmIDEwMDY0NA0KLS0tIGEvYXJjaC9taXBz
L2Nhdml1bS1vY3Rlb24vb2N0ZW9uLWlycS5jDQorKysgYi9hcmNoL21pcHMvY2F2aXVtLW9jdGVv
bi9vY3Rlb24taXJxLmMNCkBAIC0xNzA5LDcgKzE3MDksNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
b2N0ZW9uX2lycV9pbml0X2NpdTIodm9pZCkNCiAJfSBlbHNlDQogCQlwYW5pYygiQ2Fubm90IGZp
bmQgZGV2aWNlIG5vZGUgZm9yIGNhdml1bSxvY3Rlb24tNjg4MC1jaXUyLiIpOw0KIA0KLQkvKiBD
VUkyICovDQorCS8qIENJVTIgKi8NCiAJZm9yIChpID0gMDsgaSA8IDY0OyBpKyspDQogCQlvY3Rl
b25faXJxX2ZvcmNlX2NpdV9tYXBwaW5nKGNpdV9kb21haW4sIGkgKyBPQ1RFT05fSVJRX1dPUktR
MCwgMCwgaSk7DQogDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21hY2gtY2F2
aXVtLW9jdGVvbi9pcnEuaCBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9tYWNoLWNhdml1bS1vY3Rl
b24vaXJxLmgNCmluZGV4IDYwZmM0YzMuLjc3ZmI2MTAgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMv
aW5jbHVkZS9hc20vbWFjaC1jYXZpdW0tb2N0ZW9uL2lycS5oDQorKysgYi9hcmNoL21pcHMvaW5j
bHVkZS9hc20vbWFjaC1jYXZpdW0tb2N0ZW9uL2lycS5oDQpAQCAtMTUsNyArMTUsNyBAQCBlbnVt
IG9jdGVvbl9pcnEgew0KIC8qIDEgLSA4IHJlcHJlc2VudCB0aGUgOCBNSVBTIHN0YW5kYXJkIGlu
dGVycnVwdCBzb3VyY2VzICovDQogCU9DVEVPTl9JUlFfU1cwID0gMSwNCiAJT0NURU9OX0lSUV9T
VzEsDQotLyogQ0lVMCwgQ1VJMiwgQ0lVNCBhcmUgMywgNCwgNSAqLw0KKy8qIENJVTAsIENJVTIs
IENJVTQgYXJlIDMsIDQsIDUgKi8NCiAJT0NURU9OX0lSUV81ID0gNiwNCiAJT0NURU9OX0lSUV9Q
RVJGLA0KIAlPQ1RFT05fSVJRX1RJTUVSLA0KLS0gDQoxLjcuMC40DQo=
